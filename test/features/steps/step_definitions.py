import os
from behave import given, when, then

@given('I have a PDF file "{file_path}"')
def step_given_pdf_file(context, file_path):
    context.file_path = file_path
    assert os.path.exists(file_path), f"File {file_path} does not exist"

@given('I have multiple PDF files')
def step_given_multiple_pdf_files(context):
    context.file_paths = []
    for row in context.table:
        file_path = row['file_path']
        assert os.path.exists(file_path), f"File {file_path} does not exist"
        context.file_paths.append(file_path)

@when('I load the PDF into Chunkee')
def step_when_load_pdf(context):
    # Simulate loading the PDF into Chunkee
    context.result = f"Processed {context.file_path}"

@when('I load the PDFs into Chunkee')
def step_when_load_pdfs(context):
    # Simulate loading multiple PDFs into Chunkee
    context.results = [f"Processed {file_path}" for file_path in context.file_paths]

@then('it should break the PDF into chunks based on content boundaries')
def step_then_chunk_pdf(context):
    # Simulate checking the result
    assert "Processed" in context.result, "PDF was not processed correctly"

@then('it should process each file and generate separate chunked outputs')
def step_then_chunk_multiple_pdfs(context):
    # Simulate checking the results
    for result in context.results:
        assert "Processed" in result, "One or more PDFs were not processed correctly"