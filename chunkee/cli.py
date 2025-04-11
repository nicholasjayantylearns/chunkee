Chunkee CLI — Entry point for structure-aware chunking and modeling tools.

"""
This script sets up the main CLI interface for Chunkee, supporting subcommands like
`truffle-shuffle` to run the chunking pipeline on qualitative data.

Core Features:
- Modular command system via argparse subparsers
- Configurable chunking modes (semantic, structural, composite)
- Output to JSON and Neo4j-compatible Cypher
- Truffle Shuffle animation for user delight

Future commands (e.g., validate, export, merge) can be added as separate modules
under chunkee.commands for clean extension and separation of concerns.
"""

import argparse
import sys
from chunkee.commands import truffle_shuffle

def main():
    parser = argparse.ArgumentParser(
        prog='chunkee',
        description='Chunkee CLI — Structure-aware chunking of qualitative data.'
    )

    subparsers = parser.add_subparsers(dest='command', help='Available commands')

    # Truffle Shuffle command
    shuffle_parser = subparsers.add_parser(
        'truffle-shuffle',
        help='Run the Truffle Shuffle structural chunking pipeline'
    )
    shuffle_parser.add_argument('--input', '-i', required=True, help='Path to transcript or PDF file')
    shuffle_parser.add_argument('--mode', '-m', default='composite', choices=['semantic', 'structural', 'composite'], help='Chunking mode')
    shuffle_parser.add_argument('--out', '-o', default='chunkee_chunks.json', help='Output path for chunked JSON')
    shuffle_parser.add_argument('--profile', '-p', help='Optional chunking config profile')
    shuffle_parser.add_argument('--neo4j', action='store_true', help='Also export output to Neo4j-compatible .cypher')

    args = parser.parse_args()

    if args.command == 'truffle-shuffle':
        truffle_shuffle.run(args)
    else:
        parser.print_help()

if __name__ == '__main__':
    main()
