Feature: Chunk raw input into theme-aware segments

  As a user of Chunkee,
  I want to load raw transcript data,
  So that it can be automatically broken into chunks based on content themes and metadata.

  Scenario: Load and chunk raw transcript into segments
    Given I have a raw transcript with multiple paragraphs
    When I load the transcript into Chunkee
    Then it should break the transcript into chunks based on content boundaries
    And each chunk should be assigned a timestamp or paragraph index
    And the chunks should include speaker metadata (e.g., speaker ID)

  Scenario: Load and chunk raw transcript with speaker identification
    Given I have a raw transcript with speaker names and dialogue
    When I load the transcript into Chunkee
    Then the system should identify and associate each chunk with the correct speaker
    And the chunks should maintain the speaker's ID and corresponding text

  Scenario: Handle empty input gracefully
    Given I have an empty transcript
    When I load the transcript into Chunkee
    Then the system should output an error message indicating that no content was found

  Scenario: Load and chunk a PDF file
    Given I have a PDF file "tests/assets/MarisolSays.pdf"
    When I load the PDF into Chunkee
    Then it should break the PDF into chunks based on content boundaries
    And each chunk should include metadata like page number and text content

  Scenario: Handle multiple PDF files
    Given I have multiple PDF files:
      | file_path                      |
      | tests/assets/MarisolFeels.pdf |
      | tests/assets/MarisolDoes.pdf  |
    When I load the PDFs into Chunkee
    Then it should process each file and generate separate chunked outputs