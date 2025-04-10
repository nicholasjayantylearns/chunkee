# 🍫 Chunkee

**Structure-aware chunking for qualitative data.**  
Designed for RAG pipelines, graph modeling, and human-centered automation.

---

## ✨ What it does

- Segments transcripts, PDFs, and research artifacts into reusable "chunks"
- Detects structure (like empathy maps, problem rundowns, etc.)
- Adds metadata like theme, attribute, and speaker type
- Exports to:
  - JSON (for Evergreen)
  - Cypher (for Neo4j)
  - Vector DB (future)

---

## 🧪 Try It

```bash
truffle-shuffle \
  --input test/chunkee_empathy_says.json \
  --mode structural \
  --out output/chunkee_empathy_says.json \
  --neo4j
```

Paste this into Neo4j:

```cypher
MATCH (c:Chunk)-[:HAS_ATTRIBUTE]->(:Attribute {name: 'says'})
MATCH (c)-[:SPOKEN_BY]->(p:Persona)
RETURN p.name AS speaker, c.text AS statement
```

---

## 📦 Coming Soon

- `composite` mode (semantic + structural)
- Plugin support for new model formats
- Embedding + RAG integration
- CLI chunk browser

---

## 🧠 Built For

- UX researchers
- DEI strategists
- AI ethics teams
- Product ops & strategy
- Customer support insights

---

## 🛠️ License

Modified GPL — free for community use, commercial license required for SaaS or enterprise deployment.
