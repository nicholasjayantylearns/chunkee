Feature: Integrate taxonomy library for qualitative model detection

  As a user of Chunkee,
  I want to use the taxonomy library to enhance the detection taxonomy,
  So that the LLM can identify qualitative data models more effectively.

  Scenario: Enhance detection taxonomy using taxonomy library
    Given I have a taxonomy library with question and answer pairs
      | question                          | answer                              |
      | "What is the participant saying?" | "Says: Explicit statements"         |
      | "What is the participant doing?"  | "Does: Actions taken"               |
      | "What is the participant thinking?" | "Thinks: Thoughts or beliefs"     |
      | "What is the participant feeling?" | "Feels: Emotions or feelings"     |
    When I load the taxonomy library into Neo4j
    Then the Neo4j taxonomy should include the question and answer pairs
    And the taxonomy should link to the corresponding qualitative models and categories
    And the system should ensure the taxonomy is queryable by the LLM

  Scenario: Use taxonomy library to enhance LLM detection for Empathy Map
    Given the taxonomy library is loaded into Neo4j
    And the taxonomy includes the following categories for the Empathy Map model:
      | category | description                     |
      | Says     | What the participant explicitly says |
      | Does     | Actions the participant takes   |
      | Thinks   | Thoughts or beliefs of the participant |
      | Feels    | Emotions or feelings expressed  |
    When the LLM queries the Neo4j taxonomy
    Then the LLM should use the taxonomy to detect the Empathy Map model
    And the LLM should classify transcript data into the detected categories

  Scenario: Handle incomplete taxonomy library data
    Given I have an incomplete taxonomy library with missing question and answer pairs
    When I load the taxonomy library into Neo4j
    Then the system should flag the missing fields
    And the system should add a placeholder string "just add data mm/dd/yyyy & hh:mm:ss" for incomplete entries
    And the Neo4j taxonomy should include the placeholder entries
