Feature: Journey Map chunking pipeline

  As a user of Chunkee,
  I want to load raw transcript data,
  So that it can be detected, structured, and extracted into the key categories of a Journey Map: Phases, Doing, Thinking, and Feeling, with sequencing enabled for each subchunk.

  Scenario: Detect Journey Map model and categories using Neo4j taxonomy
    Given the Neo4j taxonomy is preloaded with the Journey Map model
    And the Journey Map model includes categories:
      | category | description                     |
      | Phases   | Sequential phases of the journey |
      | Doing    | Actions the participant takes   |
      | Thinking | Thoughts or beliefs of the participant |
      | Feeling  | Emotions or feelings expressed  |
    When I load a raw transcript into Chunkee
    And I use an LLM to identify qualitative data models
    Then the system should query the Neo4j taxonomy for available models
    And it should match the transcript data to the Journey Map categories
    And the system should include metadata linking each chunk to the Journey Map model
    And each subchunk should include sequencing information

  Scenario: Populate Neo4j taxonomy with Journey Map model using SDG output
    Given the SDG step generates structured data for the Journey Map model
      | category | description                     |
      | Phases   | Sequential phases of the journey |
      | Doing    | Actions the participant takes   |
      | Thinking | Thoughts or beliefs of the participant |
      | Feeling  | Emotions or feelings expressed  |
    When the SDG output is used to populate the Neo4j taxonomy
    Then the Neo4j taxonomy should include the Journey Map model and its categories
    And the LLM should query the Neo4j taxonomy to detect the Journey Map structure
    And the system should link the Journey Map categories to their respective subchunks

  Scenario: Extract an end-to-end journey map from a single transcript
    Given I have a raw transcript for Participant 001 in "tests/assets/transcript_001.txt"
    When I load the transcript into Chunkee
    And I use an LLM to identify the Journey Map model
    Then the system should dynamically assign the Journey Map model to the transcript
    And it should break the transcript into chunks based on the Journey Map categories:
      | category | description                     |
      | Phases   | Sequential phases of the journey |
      | Doing    | Actions the participant takes   |
      | Thinking | Thoughts or beliefs of the participant |
      | Feeling  | Emotions or feelings expressed  |
    And each chunk should include metadata linking it to the original transcript, Participant ID, and the Journey Map model
    And each subchunk should include sequencing information
    And the system should flag any gaps where no category could be assigned

  Scenario: Extract all possible end-to-end journey maps from multiple transcripts
    Given I have raw transcripts for Participants 001 to 010 in "tests/assets/transcripts/"
    And each transcript contains responses from a single participant
    When I load the transcripts into Chunkee
    And I use an LLM to identify the Journey Map model
    Then the system should dynamically assign the Journey Map model to each transcript
    And it should break each transcript into chunks based on the Journey Map categories:
      | category | description                     |
      | Phases   | Sequential phases of the journey |
      | Doing    | Actions the participant takes   |
      | Thinking | Thoughts or beliefs of the participant |
      | Feeling  | Emotions or feelings expressed  |
    And each chunk should include metadata linking it to the original transcript, Participant ID, and the Journey Map model
    And each subchunk should include sequencing information
    And the system should flag any gaps where no category could be assigned

  Scenario: Extract a single aggregate journey map from multiple transcripts
    Given I have raw transcripts for Participants 001 to 010 in "tests/assets/transcripts/"
    And each transcript contains responses from a single participant
    When I load the transcripts into Chunkee
    And I use an LLM to identify the Journey Map model
    Then the system should aggregate the data from all transcripts into a single Journey Map
    And it should break the aggregated data into chunks based on the Journey Map categories:
      | category | description                     |
      | Phases   | Sequential phases of the journey |
      | Doing    | Actions the participants take   |
      | Thinking | Thoughts or beliefs of the participants |
      | Feeling  | Emotions or feelings expressed  |
    And each chunk should include metadata linking it to the aggregated Journey Map and the source transcripts
    And each subchunk should include sequencing information
    And the system should flag any gaps where no category could be assigned

  Scenario: Chunk a single transcript into Journey Map categories
    Given I have a raw transcript in "tests/assets/transcript_002.txt"
    When I load the transcript into Chunkee
    And I use an LLM to identify the Journey Map model
    Then the system should dynamically assign the Journey Map model to the transcript
    And it should break the transcript into chunks based on the Journey Map categories:
      | category | description                     |
      | Steps    | Steps the participant takes     |
      | Pain     | Pain points experienced         |
    And each chunk should include metadata linking it to the original transcript, Participant ID, and the Journey Map model
    And the system should flag any gaps where no category could be assigned

  Scenario: Chunk multiple transcripts into Journey Map categories
    Given I have multiple raw transcripts in "tests/assets/transcripts/"
    And each transcript contains responses from a single participant
    When I load the transcripts into Chunkee
    And I use an LLM to identify the Journey Map model
    Then the system should dynamically assign the Journey Map model to each transcript
    And it should break each transcript into chunks based on the Journey Map categories:
      | category | description                     |
      | Steps    | Steps the participant takes     |
      | Pain     | Pain points experienced         |
    And each chunk should include metadata linking it to the original transcript, Participant ID, and the Journey Map model
    And the system should flag any gaps where no category could be assigned

  Scenario: Extract Journey Map chunks with sequencing
    Given I have a raw transcript for Participant 001 in "tests/assets/transcript_001.txt"
    And the Neo4j taxonomy includes the Journey Map model with categories:
      | category | description                     |
      | Phases   | Sequential phases of the journey |
      | Doing    | Actions the participant takes   |
      | Thinking | Thoughts or beliefs of the participant |
      | Feeling  | Emotions or feelings expressed  |
    When I load the transcript into Chunkee
    And I use an LLM to identify the Journey Map model
    Then the system should extract chunks based on the Journey Map categories
    And each chunk should include metadata linking it to the original transcript, Participant ID, and the Journey Map model
    And each subchunk should include sequencing information
    And the system should flag any gaps where no category could be assigned
