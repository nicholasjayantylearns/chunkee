Feature: Empathy Map chunking pipeline

  As a user of Chunkee,
  I want to load raw transcript data,
  So that it can be chunked into the key categories of an Empathy Map: Says, Does, Thinks, and Feels.

  Scenario: Chunk a single transcript into Empathy Map categories
    Given I have a raw transcript in "tests/assets/transcript_001.txt"
    When I load the transcript into Chunkee
    And I use an LLM to identify the Empathy Map model
    Then the system should dynamically assign the Empathy Map model to the transcript
    And it should break the transcript into chunks based on the Empathy Map categories:
      | category | description                     |
      | Says     | What the participant explicitly says |
      | Does     | Actions the participant takes   |
      | Thinks   | Thoughts or beliefs of the participant |
      | Feels    | Emotions or feelings expressed  |
    And each chunk should include metadata linking it to the original transcript, Participant ID, and the Empathy Map model
    And the system should flag any gaps where no category could be assigned

  Scenario: Chunk multiple transcripts into Empathy Map categories
    Given I have multiple raw transcripts in "tests/assets/transcripts/"
    And each transcript contains responses from a single participant
    When I load the transcripts into Chunkee
    And I use an LLM to identify the Empathy Map model
    Then the system should dynamically assign the Empathy Map model to each transcript
    And it should break each transcript into chunks based on the Empathy Map categories:
      | category | description                     |
      | Says     | What the participant explicitly says |
      | Does     | Actions the participant takes   |
      | Thinks   | Thoughts or beliefs of the participant |
      | Feels    | Emotions or feelings expressed  |
    And each chunk should include metadata linking it to the original transcript, Participant ID, and the Empathy Map model
    And the system should flag any gaps where no category could be assigned

  Scenario: Handle gaps and incomplete data during Empathy Map chunking
    Given I have a raw transcript with incomplete responses
    When I load the transcript into Chunkee
    And I use an LLM to identify the Empathy Map model
    Then the system should flag any sections of the transcript where no category could be assigned
    And it should annotate the flagged sections with metadata indicating the gap
    And it should skip processing the flagged sections

  Scenario: Use Neo4j taxonomy to identify Empathy Map
    Given the Neo4j taxonomy is preloaded with the Empathy Map model
    And the Empathy Map model includes categories:
      | category | description                     |
      | Says     | What the participant explicitly says |
      | Does     | Actions the participant takes   |
      | Thinks   | Thoughts or beliefs of the participant |
      | Feels    | Emotions or feelings expressed  |
    When I load a raw transcript into Chunkee
    And I use an LLM to identify qualitative data models
    Then the system should query the Neo4j taxonomy for available models
    And it should match the transcript data to the Empathy Map categories
    And the system should include metadata linking each chunk to the Empathy Map model

  Scenario: Use SDG output to populate Neo4j taxonomy
    Given the SDG step generates structured data for the Empathy Map model
      | category | description                     |
      | Says     | What the participant explicitly says |
      | Does     | Actions the participant takes   |
      | Thinks   | Thoughts or beliefs of the participant |
      | Feels    | Emotions or feelings expressed  |
    When the SDG output is used to populate the Neo4j taxonomy
    Then the Neo4j taxonomy should include the Empathy Map model and its categories
    And the LLM should query the Neo4j taxonomy to detect the Empathy Map structure

  Scenario: Extract Empathy Map chunks using detection taxonomy
    Given I have a raw transcript in "tests/assets/transcript_001.txt"
    And the Neo4j taxonomy includes the Empathy Map model with categories:
      | category | description                     |
      | Says     | What the participant explicitly says |
      | Does     | Actions the participant takes   |
      | Thinks   | Thoughts or beliefs of the participant |
      | Feels    | Emotions or feelings expressed  |
    When I load the transcript into Chunkee
    And I use an LLM to identify the Empathy Map model
    Then the system should extract chunks based on the Empathy Map categories
    And each chunk should include metadata linking it to the original transcript, Participant ID, and the Empathy Map model
    And the system should flag any gaps where no category could be assigned
