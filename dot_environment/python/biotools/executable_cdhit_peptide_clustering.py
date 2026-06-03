#!/usr/bin/env python3.12
import argparse
import os
import subprocess as sp
from typing import Optional

import Bio.SeqIO
import pandas as pd

CLUSTER_FILENAME = 'cdhit_clusters'

def compute_cd_hit_word_size(identity_threshold: float) -> int:
    if identity_threshold >= 0.7:
        return 5
    elif identity_threshold >= 0.6 and identity_threshold < 0.7:
        return 4
    elif identity_threshold >= 0.5 and identity_threshold < 0.6:
        return 3
    else:
        return 2

def parse_clusters(sequences_filepath: str, clusters_filepath: str) -> pd.DataFrame:
    sequences_dict = { record.id: str(record.seq) for record in Bio.SeqIO.parse(sequences_filepath, 'fasta') }
    peptides = []

    cluster_id = None
    for line in open(clusters_filepath).read().splitlines():
        if "Cluster" in line:
            cluster_id = int(line.split()[1])
        else:
            line_split = line.split()
            peptide_id = line_split[2].lstrip('>').rstrip('...')
            peptide_sequence = sequences_dict[peptide_id]
            similarity = float(line_split[-1].rstrip('%')) if '%' in line_split[-1] else 1
            peptide = {
                'cluster_id': cluster_id,
                'peptide_id': peptide_id,
                'sequence': peptide_sequence,
                'similarity': similarity
            }
            peptides.append(peptide)

    clusters_dataframe = pd.DataFrame(peptides)

    return clusters_dataframe

def cdhit(input_file: str, similarity_threshold: float, cdhit_path: str, save_intermediary_files: bool = False) -> pd.DataFrame:
    result = sp.call(f'{cdhit_path} -n {compute_cd_hit_word_size(similarity_threshold)} -c {similarity_threshold} -i {input_file} -o cdhit_clusters', shell=True)

    clusters = parse_clusters(f"{input_file}", f"{CLUSTER_FILENAME}.clstr")

    if not save_intermediary_files:
        os.remove(f'{CLUSTER_FILENAME}')
        os.remove(f'{CLUSTER_FILENAME}.clstr')

    return clusters

def main(args: dict):
    clusters_df = cdhit(args['input'], args['similarity_threshold'], args['cdhit'], save_intermediary_files=False)
    clusters_df.to_csv(args['output'], index=False)
    print(f'\nA {args["similarity_threshold"]} similarity threshold yields {len(clusters_df.cluster_id.unique())} clusters.')
    return


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='This script clusters peptides based on sequence similarity or physicochemical properties.')
    parser.add_argument('-i', '--input', required=True, type=str, help='FASTA file with the peptides to cluster.')
    #parser.add_argument('-s', '--seed', required=False, type=str, default=42, help='Seed used to initialize the non-deterministic parts of the algorithm.')
    parser.add_argument('-c', '--cdhit', required=False, type=str, help='Path to CDHIT binary.')
    parser.add_argument('-s', '--save-cdhit-files', required=False, default=False, type=bool, help='Whether the intermediary CD-HIT files should be saved.')
    parser.add_argument('-t', '--similarity_threshold', required=True, type=float, help='The sequence identity threshold to use for clustering.')
    parser.add_argument('-o', '--output', required=True, type=str, help='Path to the CSV file with the clustering results.')
    args = vars(parser.parse_args()) # yields a dictionary instead of a namespace

    main(args)
