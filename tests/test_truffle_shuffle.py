import json
import os
from chunkee.commands.truffle_shuffle import chunk_data

def test_chunk_data():
    input_data = [
        {
            "chunk_id": "chunk_0001",
            "structure": "empathy_map",
            "attribute": "says",
            "theme": "Uncertainty",
            "text": "I don't know what happens after I lose coverage.",
            "speaker": "Marisol",
            "speaker_type": "Persona",
            "source_doc": "MarisolSays.pdf"
        }
    ]
    mode = "structural"
    chunks = chunk_data(input_data, mode)

    assert len(chunks) == 1
    assert chunks[0]["chunk_id"] == "chunk_0001"
    assert chunks[0]["metadata"]["theme"] == "Uncertainty"
