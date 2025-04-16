Feature: Add a new qualitative model as a Skill

  As a user of Chunkee,
  I want to add a new qualitative model to the system as a Skill,
  So that it can be processed and integrated into the detection taxonomy.

  Scenario: Validate and add a new Skill
    Given I have a valid qna.yaml file with the following entries:
      | key             | value                                      |
      | version         | 2                                          |
      | task_description| "Classify participant actions into themes" |
      | created_by      | "github_user"                              |
      | seed_examples   | [{"question": "What is the participant doing?", "answer": "Taking notes"}] |
      | context         | "Grounded in participant behavior analysis"|
    When I push the qna.yaml file to the repository
    Then the system should validate the qna.yaml file for required fields
    And the system should trigger the SDG step to generate additional seed examples
    And the system should evaluate the generated seed examples for quality
    And the system should add the Skill as a Node in the GraphRAG with the following metadata:
      | key             | value                                      |
      | version         | 2                                          |
      | task_description| "Classify participant actions into themes" |
      | created_by      | "github_user"                              |

  Scenario: Handle invalid qna.yaml file
    Given I have an invalid qna.yaml file with missing fields
    When I push the qna.yaml file to the repository
    Then the system should flag the missing fields:
      | key             |
      | version         |
      | task_description|
    And the system should reject the qna.yaml file
    And the SDG step should not be triggered

  Scenario: Add generated seed examples to GraphRAG
    Given the SDG step generates additional seed examples
      | question                          | answer                              |
      | "What is the participant saying?" | "Says: Explicit statements"         |
      | "What is the participant doing?"  | "Does: Actions taken"               |
    When the seed examples are evaluated for quality
    Then the system should add the validated seed examples to the GraphRAG as Nodes
    And the Nodes should link to the Skill Node with the following metadata:
      | key             | value                                      |
      | version         | 2                                          |
      | task_description| "Classify participant actions into themes" |
      | created_by      | "github_user"                              |
    And the system should ensure the Skill Node is queryable by the LLM

  Scenario: Trigger SDG step on valid Skill submission
    Given I have a valid qna.yaml file
    When I push the qna.yaml file to the repository
    Then the system should trigger the SDG step
    And the SDG step should generate additional seed examples
    And the system should evaluate the generated seed examples for quality
    And the system should add the Skill and seed examples to the GraphRAG
