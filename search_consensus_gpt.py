import paramiko
import re
import os
import datetime
from Bio import SeqIO
from io import StringIO
import pandas as pd
import concurrent.futures

# Function to generate a regex pattern from the consensus sequence
def generate_regex_pattern(consensus_sequence):
    pattern = consensus_sequence.upper().replace('N', '.')
    return pattern

# Function to search for matching sequences in the genome and export matches with relative coordinates to gene start
# Does the function start at 0 or 1? tbd
def search_matching_sequences_relative(genome_fasta_text, pattern):
    matches = []
    genome_fasta = StringIO(genome_fasta_text)
    for record in SeqIO.parse(genome_fasta, "fasta"):
        for match in re.finditer(pattern, str(record.seq)):
            matches.append((record.id, match.start(), match.end()))
    return matches

# Function to search for the matches in chunks of varying size, rather than all at once to avoid memory issues
# Chunk size = # of lines to read at a time, could probably go a lot higher?
def search_matching_sequences_chunked(genome_fasta_path, pattern, chunk_size=100):
    matches = []
    temp_fasta_path = "temp_chunk.fasta"
    genome_fasta_file = open(genome_fasta_path, "r")

    while True:
        chunk = ''
        for _ in range(chunk_size):
            line = genome_fasta_file.readline()
            if not line:
                break
            chunk += line

        if not chunk:
            break

        chunk_fasta = StringIO(chunk)
        chunk_matches = search_matching_sequences(chunk_fasta, pattern)
        matches.extend(chunk_matches)

    genome_fasta_file.close()
    return matches

# Supposedly the same function but now running asychronously in parallel, with the function get_chunks needed unlike above
def search_matching_sequences_chunked_parallel(genome_fasta_path, pattern, chunk_size=100, num_workers=None):
    matches = []

    with open(genome_fasta_path, "r") as genome_fasta_file:
        chunks = get_chunks(genome_fasta_file, chunk_size)

        with concurrent.futures.ProcessPoolExecutor(max_workers=num_workers) as executor:
            future_chunks = {executor.submit(search_matching_sequences, chunk, pattern): chunk for chunk in chunks}
            for future in concurrent.futures.as_completed(future_chunks):
                chunk = future_chunks[future]
                try:
                    chunk_matches = future.result()
                    matches.extend(chunk_matches)
                except Exception as e:
                    print(f"An error occurred while processing chunk: {chunk}\nError: {e}")

    return matches

def get_chunks(genome_fasta_file, chunk_size):
    chunks = []
    while True:
        chunk = ''
        for _ in range(chunk_size):
            line = genome_fasta_file.readline()
            if not line:
                break
            chunk += line

        if not chunk:
            break

        chunks.append(StringIO(chunk))

    return chunks

# Function to search for matching sequences in the genome and export matches with global coordinates
def search_matching_sequences(genome_fasta_text, pattern):
    matches = []
    genome_fasta = StringIO(genome_fasta_text)
    for record in SeqIO.parse(genome_fasta, "fasta"):
        gene_coords_match = re.search(r'loc:\d+\((?:\+|-)\)(\d+)-(\d+)', record.description)  # Extract gene start and end positions
        if gene_coords_match:
            gene_start = int(gene_coords_match.group(1))
            gene_end = int(gene_coords_match.group(2))
            for match in re.finditer(pattern, str(record.seq)):
                global_start = gene_start + match.start()
                global_end = gene_start + match.end()
                matches.append((record.id, global_start, global_end))
    return matches

# Function to save the results to a CSV file
def save_results_to_csv(matches, output_file):
    df = pd.DataFrame(matches, columns=['Contig', 'Start', 'End'])
    df.to_csv(output_file, index=False)

# Function to save the results to a BED file
# For global DNA coordinates
def save_results_to_bed(matches, output_file):
    with open(output_file, "w") as bed_file:
        for match in matches:
            bed_file.write(f"{match[0]}\t{match[1]}\t{match[2]}\n")

# Function to save the matching sequences to a FASTA file
def save_matching_sequences_to_fasta(matches, genome_fasta_text, output_file):
    matching_sequences = []
    genome_fasta = StringIO(genome_fasta_text)
    records = SeqIO.to_dict(SeqIO.parse(genome_fasta, "fasta"))
    for contig, start, end in matches:
        matching_sequence = records[contig][start:end]
        matching_sequences.append(matching_sequence)
    SeqIO.write(matching_sequences, output_file, "fasta")

# Function to create a README file with a summary of the analysis
def create_readme(genome_name, consensus_sequence, output_files, readme_file="README.txt"):
    with open(readme_file, "w") as f:
        f.write("Genome Analysis Summary\n")
        f.write("========================\n\n")
        f.write(f"Genome name: {genome_name}\n")
        f.write(f"Consensus sequence: {consensus_sequence}\n\n")
        f.write("Output files:\n")
        for output_file in output_files:
            f.write(f" - {output_file}\n")

#
# SSH functionality in order to run it abroad, or without having the files locally - caching defeats this purpose, but... speed
#
# SSH connection and file transfer settings
ssh_hostname = "lcc.uky.edu"
ssh_username = "blri233"
ssh_password = "gorgonzola 69B!@#" # Don't steal my identity there is nothing of value on there

# Reverse transcribed sequences
# cdna, cds, or pep
seq_type = "cdna"
remote_genome_fasta_path = '/project/awse225_uksr/genome_assemblies/cahirinus/ACOCA10068_EIv1_annotation/Frozen_release_19Oct2018/EIv1/annotation/ACOCA10068_EIv1.annotation.gff3.' + seq_type + '.fasta'

# Contigless genome? There are other options in dropbox
remote_genome_contigless_path = '/project/awse225_uksr/genome_assemblies/cahirinus/ACOCA10068_EIv1_annotation/Frozen_release_19Oct2018/EIv1/assembly/mAcoCah1.10X.asm2.pseudohap1.clipped.onecontigless.fa'


# Connect to the remote server and download the genome FASTA file
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(ssh_hostname, username=ssh_username, password=ssh_password)

sftp = ssh.open_sftp()
remote_genome_fasta = sftp.file(remote_genome_contigless_path)
genome_fasta_text = remote_genome_fasta.read().decode('utf-8')

# cache the genome fasta text to a file and read it from there instead of the ssh connection
with open('./genome_fasta_cache.fa', 'w') as f:
    f.write(genome_fasta_text)

remote_genome_fasta.close()
sftp.close()
ssh.close()

#consensus_sequence 
#with open('./consensus_sequence.txt', 'r') as f:
#    consensus_sequence = f.read()

consensus_sequence = "CCGCGNGGNGGCAG" # canonical CTCF binding motif

# Output files
output_fasta_file = './output/matching_genes' + datetime.datetime.now().strftime("%Y%m%d-%H%M%S") + '.fasta'

output_bed_file = './output/matching_coordinates.bed' + datetime.datetime.now().strftime("%Y%m%d-%H%M%S") +  '.bed'

output_files = [output_fasta_file, output_bed_file]

#
# Main script
#
print("Searching for matching sequences in the genome using the consensus sequence: \n" + consensus_sequence + "\n")

# Generate regex pattern
pattern = generate_regex_pattern(consensus_sequence)

# Search for matching sequences in the genome
matches = search_matching_sequences_chunked_parallel(genome_fasta_text, pattern, chunk_size=100)

# Save the matching sequences to a FASTA file
save_matching_sequences_to_fasta(matches, genome_fasta_text, output_fasta_file)

# Save the matching coordinates to a BED file
save_results_to_bed(matches, output_bed_file)

print("Done! Results saved to " + output_fasta_file + " and " + output_bed_file + "\n")
create_readme(remote_genome_contigless_path, consensus_sequence, output_files)
