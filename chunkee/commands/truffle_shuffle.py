import json
import os

def run(args):
    """
    Run the Truffle Shuffle chunking pipeline.

    Args:
        args: Parsed arguments from the CLI.
    """
    input_path = args.input
    output_path = args.out
    mode = args.mode
    neo4j_export = args.neo4j

    # Validate input file
    if not os.path.exists(input_path):
        print(f"Error: Input file '{input_path}' does not exist.")
        return

    # Load input data
    with open(input_path, 'r') as f:
        data = json.load(f)

    # Perform chunking based on mode
    chunks = chunk_data(data, mode)

    # Save output to JSON
    with open(output_path, 'w') as f:
        json.dump(chunks, f, indent=2)
    print(f"Chunks saved to {output_path}")

    # Optionally export to Neo4j Cypher
    if neo4j_export:
        from chunkee.export.empathy_map_cypher import generate_empathy_map_chunk_cypher
        cypher_output = output_path.replace('.json', '.cypher')
        with open(cypher_output, 'w') as f:
            f.write(generate_empathy_map_chunk_cypher(chunks))
        print(f"Cypher export saved to {cypher_output}")

def chunk_data(data, mode):
    """
    Chunk the input data based on the specified mode.

    Args:
        data: Input data to be chunked.
        mode: Chunking mode ('semantic', 'structural', 'composite').

    Returns:
        List of chunked data.
    """
    # Placeholder logic for chunking
    chunks = []
    for item in data:
        chunk = {
            "chunk_id": item.get("chunk_id", "unknown"),
            "text": item.get("text", ""),
            "metadata": {
                "structure": item.get("structure", "unknown"),
                "attribute": item.get("attribute", "unknown"),
                "theme": item.get("theme", "unknown"),
                "speaker": item.get("speaker", "unknown"),
                "speaker_type": item.get("speaker_type", "unknown"),
                "source_doc": item.get("source_doc", "unknown"),
            }
        }
        chunks.append(chunk)
    return chunks
