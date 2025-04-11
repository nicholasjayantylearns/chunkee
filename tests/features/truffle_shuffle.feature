Feature: Truffle Shuffle chunking pipeline

  As a user of Chunkee,
  I want to use the Truffle Shuffle command,
  So that I can chunk qualitative data into structured segments.

  Scenario: Chunk data using structural mode
    Given I have a valid input file "test/chunkee_empathy_says.json"
    When I run the "truffle-shuffle" command with mode "structural"
    Then the system should generate a JSON file with chunked data
    And the output file should contain chunks with metadata

  Scenario: Export chunks to Neo4j Cypher
    Given I have a valid input file "test/chunkee_empathy_says.json"
    When I run the "truffle-shuffle" command with the "--neo4j" flag
    Then the system should generate a Cypher file with chunk relationships
