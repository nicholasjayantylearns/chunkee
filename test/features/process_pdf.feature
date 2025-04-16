Feature: Process PDF files

  Scenario: Load and process a single PDF file
    Given I have a PDF file "tests/assets/sample.pdf"
    When I load the PDF into Chunkee
    Then it should detect qualitative models in the PDF
    And it should extract the content from the PDF
    And it should generate structured chunks based on the detected models

  Scenario: Load and process multiple PDF files
    Given I have multiple PDF files
      | file_path                  |
      | tests/assets/sample1.pdf  |
      | tests/assets/sample2.pdf  |
    When I load the PDFs into Chunkee
    Then it should detect qualitative models in each PDF
    And it should extract the content from each PDF
    And it should generate structured chunks for each PDF
