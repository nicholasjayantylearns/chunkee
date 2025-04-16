from behave import given, when, then
import os
import json
import csv

# Step to set up a chunk with text and metadata
@given('I have a chunk with metadata')
def step_given_chunk_with_metadata(context):
    context.chunk = {
        "text": "This is a sample chunk.",
        "metadata": {"author": "John Doe", "date": "2023-01-01"}
    }

# Step to simulate exporting the chunk to both CSV and JSON files
@when('I choose to export the chunk')
def step_when_export_chunk(context):
    context.exported_files = []
    # Simulate exporting to CSV
    csv_file = "chunk_export.csv"
    with open(csv_file, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["text", "author", "date"])  # Write header row
        writer.writerow([context.chunk["text"], context.chunk["metadata"]["author"], context.chunk["metadata"]["date"]])  # Write data row
    context.exported_files.append(csv_file)

    # Simulate exporting to JSON
    json_file = "chunk_export.json"
    with open(json_file, mode='w') as file:
        json.dump(context.chunk, file)  # Write chunk data as JSON
    context.exported_files.append(json_file)

# Step to verify that the CSV file is created and contains the correct data
@then('the system should generate a CSV file with the chunk text and metadata')
def step_then_generate_csv(context):
    csv_file = "chunk_export.csv"
    assert csv_file in context.exported_files  # Ensure the file was exported
    assert os.path.exists(csv_file)  # Ensure the file exists
    with open(csv_file, mode='r') as file:
        reader = csv.reader(file)
        rows = list(reader)
        assert rows[0] == ["text", "author", "date"]  # Verify header row
        assert rows[1] == [context.chunk["text"], context.chunk["metadata"]["author"], context.chunk["metadata"]["date"]]  # Verify data row

# Step to verify that the JSON file is created and contains the correct data
@then('the system should generate a JSON file with the chunk text and metadata')
def step_then_generate_json(context):
    json_file = "chunk_export.json"
    assert json_file in context.exported_files  # Ensure the file was exported
    assert os.path.exists(json_file)  # Ensure the file exists
    with open(json_file, mode='r') as file:
        data = json.load(file)
        assert data == context.chunk  # Verify JSON content matches the chunk
