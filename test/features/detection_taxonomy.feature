Feature: Detection taxonomy for qualitative models

  As a user of Chunkee,
  I want to detect and dynamically assign qualitative models to data,
  So that I can structure and analyze the data effectively.

  Scenario: Detect qualitative models using SDG and RAG
    Given the SDG step generates structured data for qualitative models
    And the Neo4j taxonomy is preloaded with the structured data
    When I load a raw transcript into Chunkee
    And I use an LLM to identify qualitative data models
    Then the system should query the Neo4j taxonomy for available models
    And it should dynamically assign qualitative models to different parts of the transcript
    And the system should include metadata linking each chunk to the identified model

  Scenario: Handle multiple qualitative models in a single transcript
    Given I have a raw transcript with multiple themes
    When I load the transcript into Chunkee
    And I use an LLM to identify qualitative data models
    Then the system should assign different parts of the transcript to different qualitative models
    And it should dynamically chunk the transcript based on the assigned models
    And the system should include metadata linking each chunk to its respective model
