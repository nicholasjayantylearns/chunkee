Feature: Visualize chunk relationships in a graph

  As a user of Chunkee,
  I want to visualize chunk relationships in a graph format,
  So that I can better understand the structure and dependencies between chunks.

  Scenario: Generate a graph of chunk relationships
    Given I have multiple chunks with metadata
    When I visualize the chunks in Chunkee
    Then the system should generate a graph showing the relationships between chunks based on themes or speaker IDs

  Scenario: View chunk dependencies in graph
    Given I have chunks with interdependencies
    When I view the chunk graph
    Then the system should show the dependencies between chunks in a clear, readable format