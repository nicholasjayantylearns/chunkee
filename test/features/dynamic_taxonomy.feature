Feature: Dynamic taxonomy generation and extension

  As a user of Chunkee,
  I want to generate and extend a taxonomy dynamically for my dataset,
  So that the system can adapt to the specific data and evolve as more data is added.

  Scenario: Generate a dynamic taxonomy for a dataset using SDG and RAG
    Given the SDG step generates structured data for qualitative models
      | model         | category | description                     |
      | Empathy Map   | Says     | What the participant explicitly says |
      | Journey Map   | Phases   | Sequential phases of the journey |
    And the Neo4j taxonomy is preloaded with the structured data
    When I load a raw transcript into Chunkee
    And I use an LLM to identify qualitative data models
    Then the system should query the Neo4j taxonomy for available models
    And it should dynamically assign qualitative models to different parts of the transcript
    And the system should generate a GraphRAG database taxonomy specific to the dataset
    And the taxonomy should include metadata linking it to the dataset and the identified models

  Scenario: Extend the dynamic taxonomy as new data is added
    Given I have an existing GraphRAG database taxonomy for my dataset
    And I have new raw transcripts to add to the dataset
    When I load the new transcripts into Chunkee
    And I use an LLM to identify qualitative data models
    Then the system should update the GraphRAG database taxonomy with the new data
    And it should dynamically extend the taxonomy with any new models or categories identified
    And the updated taxonomy should remain queryable by the LLM

  Scenario: Enhance detection taxonomy using taxonomy library
    Given I have a taxonomy library with question and answer pairs
      | question                          | answer                              |
      | "What is the participant saying?" | "Says: Explicit statements"         |
      | "What is the participant doing?"  | "Does: Actions taken"               |
    When I load the taxonomy library into Neo4j
    Then the Neo4j taxonomy should include the question and answer pairs
    And the taxonomy should link to the corresponding qualitative models and categories
    And the system should ensure the taxonomy is queryable by the LLM
