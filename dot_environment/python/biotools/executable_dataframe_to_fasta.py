import argparse
import pandas as pd


def main(args):
    df = pd.read_csv(args["input"])

    entries = []

    for index, row in df.iterrows():
        if args["id_col"]:
            id = str(row[args["id_col"]])
        else:
            if not args["prefix"]:
                raise Exception(
                    "There is no `id_col` so you must provide a prefix for the peptide names."
                )
            id = f'{args["prefix"]}{index}'

        entries.append(f'>{id}\n{row[args["seq_col"]]}')

    fasta_content = "\n".join(entries)

    with open(args["output"], "w") as output_file:
        output_file.write(fasta_content)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Converts a raw list of peptides (one per line) to FASTA format."
    )
    parser.add_argument(
        "-i",
        "--input",
        required=True,
        type=str,
        help="FASTA file with the peptides to cluster.",
    )
    parser.add_argument(
        "-p",
        "--prefix",
        required=False,
        type=str,
        help="Prefix to append in front of protein/peptide number.",
    )
    parser.add_argument(
        "-s",
        "--seq_col",
        required=True,
        type=str,
        help="Name of the column with the sequences.",
    )
    parser.add_argument(
        "-d",
        "--id_col",
        required=False,
        type=str,
        help="Name of the column with the IDs.",
    )
    parser.add_argument(
        "-o",
        "--output",
        required=True,
        type=str,
        help="Path to the CSV file with the clustering results.",
    )
    args = vars(parser.parse_args())  # yields a dictionary instead of a namespace

    main(args)
