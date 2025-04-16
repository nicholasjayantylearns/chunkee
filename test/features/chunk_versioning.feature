Feature: Version chunks for traceability

  As a user of Chunkee,
  I want to ensure that chunks can be versioned,
  So that changes to chunks can be tracked and traced.

  Scenario: Version a chunk after modification
    Given I have a chunk of text with metadata
    When I modify the chunk text
    Then the system should create a new version of the chunk

  Scenario: Retrieve previous versions of a chunk
    Given I have a chunk with multiple versions
    When I retrieve an earlier version of the chunk
    Then I should see the chunk content and metadata from the previous version