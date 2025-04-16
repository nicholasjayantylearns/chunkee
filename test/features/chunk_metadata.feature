Feature: Store metadata for chunks

  As a user of Chunkee,
  I want to store metadata for each chunk,
  So that each chunk is traceable and contextually meaningful.

  Scenario: Store metadata with chunk
    Given I have a chunk of text
    When I process the chunk through Chunkee
    Then the chunk should be stored with metadata such as:
      | theme    | speaker_id | timestamp |
      | 'Topic A'| 'Speaker1' | '00:00:05' |

  Scenario: Retrieve chunk with metadata
    Given I have processed a chunk
    When I retrieve the chunk from Chunkee
    Then the chunk should include its metadata:
      | theme    | speaker_id | timestamp |
      | 'Topic A'| 'Speaker1' | '00:00:05' |