#!/usr/bin/env python3.12
import argparse

import pandas as pd

def main(args):
    if args['txt']:
        sequences = open(args['input']).read().splitlines()

        with open(args['output'], 'w') as output_file:
            for i, seq in enumerate(sequences):
                output_file.write(f'>{args["prefix"]}{i+1}\n{seq}\n')

        print(f'Converted a file with {len(sequences)} sequences to FASTA format.')
        return

    if not args['sequence_col'] or not args['id_col']:
        raise "You must provide the arguments `sequence_col` and `id_col`."

    df = pd.read_csv(args['input'])

    with open(args['output'], 'w') as ofile:
        ofile.write("\n".join(df.apply(lambda x: f'>{args["prefix"] + x[args["id_col"]]}\n{x[args["sequence_col"]]}', axis=1)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Converts a raw list of peptides (one per line) or CSV to FASTA format.')
    parser.add_argument('-i', '--input', required=True, type=str, help='Input file.')
    parser.add_argument('-t', '--txt', action='store_true', help='Peptides are in a text file (one peptide per line).')
    parser.add_argument('-p', '--prefix', required=True, type=str, help='Prefix to append in front of protein/peptide number.')
    parser.add_argument('-s', '--sequence_col', required=False, type=str, help='If CSV, name of the column with the sequences.')
    parser.add_argument('-d', '--id_col', required=False, type=str, help='If CSV, name of the column with the sequence IDs.')
    parser.add_argument('-o', '--output', required=True, type=str, help='Path to the output FASTA file.')
    args = vars(parser.parse_args()) # yields a dictionary instead of a namespace

    main(args)
