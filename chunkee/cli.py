# chunkee/cli.py
import argparse
import time
import os
import json
from chunkee.engine import run_chunking_pipeline
from chunkee.export import generate_empathy_map_chunk_cypher

def truffle_shuffle_animation():
    frames = [
        "(>'-')>   ",
        "(>'-')> <('-'<)",
        "^('-')^  <('-'<)  ^('-')^",
        "<('-'<)   (>'-')>   ^('-')^",
        "CHUNK IT.  SHAKE IT.  STRUCTURE IT."
    ]
    print("\n🥾 Performing the Truffle Shuffle...\n")
    for frame in frames:
        print(frame)
        time.sleep(0.6)
    print("\n✨ Let's make these transcripts dance. ✨\n")

def main():
    parser = argparse.ArgumentParser(
        prog='truffle-shuffle',
        description='Chunkee CLI — Structure-aware chunking of qualitative data.'
    )
    parser.add_argument('--input', '-i', required=True, help='Path to transcript or PDF file')
    parser.add_argument('--mode', '-m', default='composite', choices=['semantic', 'structural', 'composite'], help='Chunking mode')
    parser.add_argument('--out', '-o', default='chunkee_chunks.json', help='Output path for chunked JSON')
    parser.add_argument('--profile', '-p', help='Optional chunking config profile')
    parser.add_argument('--neo4j', action='store_true', help='Also export output to Neo4j-compatible .cypher')

    args = parser.parse_args()
    truffle_shuffle_animation()

    run_chunking_pipeline(
        input_path=args.input,
        output_path=args.out,
        mode=args.mode,
        profile=args.profile
    )

    print(f"\n✅ Chunked output written to {args.out}")

    if args.neo4j:
        try:
            with open(args.out, 'r') as f:
                chunks = json.load(f)
            cypher = generate_empathy_map_chunk_cypher(chunks)
            cypher_path = args.out.replace('.json', '.cypher')
            with open(cypher_path, 'w') as out:
                out.write(cypher)
            print(f"✅ Neo4j Cypher file exported: {cypher_path}")
        except Exception as e:
            print(f"⚠️ Failed to export Cypher: {e}")

if __name__ == '__main__':
    main()
