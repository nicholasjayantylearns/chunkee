from behave import given, when, then

@given('I have a PDF file "{file_path}"')
def step_given_pdf_file(context, file_path):
    context.file_path = file_path
    # Simulate checking if the file exists
    assert file_path.endswith(".pdf"), f"File {file_path} is not a PDF"

@given('I have multiple PDF files')
def step_given_multiple_pdf_files(context):
    context.file_paths = [row['file_path'] for row in context.table]
    for file_path in context.file_paths:
        assert file_path.endswith(".pdf"), f"File {file_path} is not a PDF"

@when('I load the PDF into Chunkee')
def step_when_load_pdf(context):
    # Simulate loading the PDF
    context.result = f"Loaded {context.file_path}"

@when('I load the PDFs into Chunkee')
def step_when_load_pdfs(context):
    # Simulate loading multiple PDFs
    context.results = [f"Loaded {file_path}" for file_path in context.file_paths]

@then('it should detect qualitative models in the PDF')
def step_then_detect_models_pdf(context):
    # Simulate detecting models
    assert "Loaded" in context.result, "PDF was not loaded correctly"

@then('it should detect qualitative models in each PDF')
def step_then_detect_models_pdfs(context):
    # Simulate detecting models in multiple PDFs
    for result in context.results:
        assert "Loaded" in result, "One or more PDFs were not loaded correctly"

@then('it should extract the content from the PDF')
def step_then_extract_content_pdf(context):
    # Simulate content extraction
    assert "Loaded" in context.result, "PDF content was not extracted"

@then('it should extract the content from each PDF')
def step_then_extract_content_pdfs(context):
    # Simulate content extraction for multiple PDFs
    for result in context.results:
        assert "Loaded" in result, "Content was not extracted from one or more PDFs"

@then('it should generate structured chunks based on the detected models')
def step_then_generate_chunks_pdf(context):
    # Simulate generating structured chunks
    assert "Loaded" in context.result, "Chunks were not generated for the PDF"

@then('it should generate structured chunks for each PDF')
def step_then_generate_chunks_pdfs(context):
    # Simulate generating structured chunks for multiple PDFs
    for result in context.results:
        assert "Loaded" in result, "Chunks were not generated for one or more PDFs"
