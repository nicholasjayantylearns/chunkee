Feature: Export chunks for further analysis

  As a user of Chunkee,
  I want to export chunks,
  So that I can analyze them externally or share them with others.

  Scenario: Export chunk data to CSV
    Given I have a chunk with metadata
    When I choose to export the chunk
    Then the system should generate a CSV file with the chunk text and metadata

  Scenario: Export chunk data to JSON
    Given I have a chunk with metadata
    When I choose to export the chunk
    Then the system should generate a JSON file with the chunk text and metadata