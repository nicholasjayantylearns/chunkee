Feature: Visualize and export structured data

  As a user of Chunkee,
  I want to visualize and export structured data,
  So that I can analyze and share the data effectively.

  Scenario: Visualize chunk relationships in a graph
    Given I have multiple chunks with metadata
    When I visualize the chunks in Chunkee
    Then the system should generate a graph showing the relationships between chunks based on themes or speaker IDs

  Scenario: Export chunk data to CSV
    Given I have a chunk with metadata
    When I choose to export the chunk
    Then the system should generate a CSV file with the chunk text and metadata

  Scenario: Export chunk data to JSON
    Given I have a chunk with metadata
    When I choose to export the chunk
    Then the system should generate a JSON file with the chunk text and metadata
