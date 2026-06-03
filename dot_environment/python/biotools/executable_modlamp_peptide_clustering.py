#!/usr/bin/env python3.12

import argparse
import os
import subprocess as sp
from typing import Optional, List

import numpy as np
import pandas as pd
import Bio.SeqIO

from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from modlamp.descriptors import GlobalDescriptor

def extract_descriptors(sequences: list) -> np.array:
    # Extract descriptors
    desc = GlobalDescriptor(sequences)
    desc.calculate_all()

    # Keep 'Charge', 'ChargeDensity', 'pI', 'InstabilityInd', 'Aromaticity', 'AliphaticInd', 'BomanInd', 'HydrophRatio'
    feature_matrix = desc.descriptor[:, 2:]

    # Standardize the features
    scaler = StandardScaler()
    scaled_feature_matrix = scaler.fit_transform(feature_matrix)

    return scaled_feature_matrix


def main(args: dict):
    peptides = [(pep.id, str(pep.seq)) for pep in Bio.SeqIO.parse(args['input'], 'fasta')]
    peptide_ids = [pep[0] for pep in peptides]
    sequences = [pep[1] for pep in peptides]

    feature_matrix = extract_descriptors(sequences)

    clusterer = KMeans(n_clusters=args['n_clusters'], random_state=args['seed'])
    clusterer.fit(feature_matrix)

    df = pd.DataFrame({ 'peptide_id': peptide_ids, 'sequence': sequences, 'cluster_id': clusterer.labels_ })
    df.sort_values(by=('cluster_id'), inplace=True, ascending=True)

    df.to_csv(args['output'], index=False)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='This script clusters peptides based on sequence similarity or physicochemical properties.')
    parser.add_argument('-i', '--input', required=True, type=str, help='FASTA file with the peptides to cluster.')
    parser.add_argument('-s', '--seed', required=False, type=int, default=42, help='Seed used to initialize the non-deterministic parts of the algorithm.')
    parser.add_argument('-n', '--n_clusters', required=True, type=int, help='Number of clusters to use for clustering.')
    parser.add_argument('-o', '--output', required=True, type=str, help='Path to the CSV file with the clustering results.')
    args = vars(parser.parse_args()) # yields a dictionary instead of a namespace

    main(args)
