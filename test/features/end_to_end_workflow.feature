Feature: End-to-end workflow for Chunkee

  As a user of Chunkee,
  I want to detect, extract, and generate a taxonomy unique to my dataset,
  And extend the detection taxonomy to include new qualitative models,
  So that I can analyze my data effectively and evolve the taxonomy over time.

  Scenario: Detect, extract, and generate a taxonomy for a dataset
    Given I have 10 raw transcripts from user interviews in "tests/assets/transcripts/"
    And the Detection GraphRAG is preloaded with a detection taxonomy for qualitative models
    When I load the transcripts into Chunkee
    And I use an LLM to detect qualitative data models in the transcripts
    Then the system should query the Detection GraphRAG for relevant models
    And it should dynamically assign qualitative models to different parts of the transcripts
    And the system should extract chunks based on the detected models and categories
    And the system should generate a new GraphRAG taxonomy unique to my dataset
    And the taxonomy should include metadata linking it to the dataset and the detected models

  Scenario: Extend the Detection GraphRAG with a new qualitative model
    Given I have a new qualitative model defined in a qna.yaml file with the following entries:
      | key             | value                                      |
      | version         | 2                                          |
      | task_description| "Classify participant actions into themes" |
      | created_by      | "github_user"                              |
      | seed_examples   | [{"question": "What is the participant doing?", "answer": "Taking notes"}] |
      | context         | "Grounded in participant behavior analysis"|
    When I push the qna.yaml file to the repository
    Then the system should validate the qna.yaml file for required fields
    And the system should trigger the SDG workflow to generate additional seed examples
    And the system should evaluate the generated seed examples for quality
    And the system should add the new qualitative model and seed examples to the Detection GraphRAG
    And the updated Detection GraphRAG should remain queryable by the LLM
