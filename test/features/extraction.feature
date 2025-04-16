Feature: Extract structured data using detection taxonomy

  As a user of Chunkee,
  I want to extract structured data using the dynamically generated taxonomy,
  So that I can analyze and visualize the data effectively.

  Scenario: Extract Empathy Map chunks using dynamic taxonomy
    Given I have a raw transcript in "tests/assets/transcript_001.txt"
    And the GraphRAG database taxonomy includes the Empathy Map model with categories:
      | category | description                     |
      | Says     | What the participant explicitly says |
      | Does     | Actions the participant takes   |
    When I load the transcript into Chunkee
    And I use an LLM to identify the Empathy Map model
    Then the system should extract chunks based on the Empathy Map categories
    And each chunk should include metadata linking it to the original transcript, Participant ID, and the Empathy Map model

  Scenario: Extract Journey Map chunks with sequencing using dynamic taxonomy
    Given I have a raw transcript for Participant 001 in "tests/assets/transcript_001.txt"
    And the GraphRAG database taxonomy includes the Journey Map model with categories:
      | category | description                     |
      | Phases   | Sequential phases of the journey |
      | Doing    | Actions the participant takes   |
    When I load the transcript into Chunkee
    And I use an LLM to identify the Journey Map model
    Then the system should extract chunks based on the Journey Map categories
    And each chunk should include metadata linking it to the original transcript, Participant ID, and the Journey Map model
    And each subchunk should include sequencing information
