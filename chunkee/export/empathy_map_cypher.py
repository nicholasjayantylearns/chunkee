# empathy_map_cypher.py
from hashlib import sha256

def sanitize(text):
    return text.replace('"', '\"').replace("'", "\'")

def generate_empathy_map_chunk_cypher(chunks):
    statements = []
    for chunk in chunks:
        cid = chunk.get("chunk_id") or sha256(chunk['text'].encode()).hexdigest()[:10]
        text = sanitize(chunk['text'])
        structure = chunk.get('structure', 'empathy_map')
        attribute = chunk.get('attribute', 'unknown')
        theme = chunk.get('theme', 'General')
        model = structure
        source = chunk.get('source_doc', 'unknown')
        speaker = chunk.get('speaker', 'Unknown')
        speaker_type = chunk.get('speaker_type', 'Participant')

        statement = (
            f"MERGE (c:Chunk {{chunk_id: '{cid}'}})\n"
            f"  SET c.text = '{text}', c.source = '{source}'\n"
            f"MERGE (m:EDTModel {{name: '{model}'}})\n"
            f"MERGE (a:Attribute {{name: '{attribute}'}})\n"
            f"MERGE (t:Theme {{name: '{sanitize(theme)}'}})\n"
            f"MERGE (s:{speaker_type} {{name: '{sanitize(speaker)}'}})\n"
            f"MERGE (c)-[:PART_OF_MODEL]->(m)\n"
            f"MERGE (c)-[:HAS_ATTRIBUTE]->(a)\n"
            f"MERGE (c)-[:HAS_THEME]->(t)\n"
            f"MERGE (c)-[:SPOKEN_BY]->(s)"
        )
        statements.append(statement)

    return "\n\n".join(statements)
