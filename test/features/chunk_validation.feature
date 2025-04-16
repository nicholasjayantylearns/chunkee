Feature: Validate chunk data integrity

  As a user of Chunkee,
  I want to validate chunk data,
  So that I can ensure that the chunk is complete and accurate.

  Scenario: Validate chunk metadata
    Given I have a chunk with incomplete metadata
    When I validate the chunk
    Then the system should flag the chunk as incomplete or invalid

  Scenario: Validate chunk text integrity
    Given I have a chunk with corrupted text
    When I validate the chunk
    Then the system should flag the chunk as corrupted and require a fix