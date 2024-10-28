import csv
import re

input_csv_path = "/home/victoria/training_data/combined_training_data/combined_training_data.csv"
output_csv_path = "/home/victoria/training_data/combined_training_data/combined_training_data_cleaned.csv"

def clean_transcription(transcription):
    cleaned_text = re.sub(r'\s+', ' ', transcription).strip()
    return cleaned_text.replace('#', '')

with open(input_csv_path, mode='r', encoding='utf-8') as input_file, \
     open(output_csv_path, mode='w', newline='', encoding='utf-8') as output_file:
    
    reader = csv.DictReader(input_file, delimiter='|')
    writer = csv.DictWriter(output_file, fieldnames=reader.fieldnames, delimiter='|')
    
    writer.writeheader()
    
    for row in reader:
        row['transcription'] = clean_transcription(row['transcription'])
        writer.writerow(row)

print("CSV file cleaned and saved to", output_csv_path)
