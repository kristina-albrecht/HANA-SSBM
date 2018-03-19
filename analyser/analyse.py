#!/usr/bin/env python3
import argparse
from util.analyser import Analyser

def parse_args():
    parser = argparse.ArgumentParser(description="Analyse your Benchmark log")
    parser.add_argument(
        "path_to_log",
        help="Path to File containing the logs of the benchmark."
    )
    return vars(parser.parse_args())

def main():
    """ Main function """
    args = parse_args()
    path_to_log = args["path_to_log"]
    analyser = Analyser(path_to_log)
    analyser.print_stats()

main()
