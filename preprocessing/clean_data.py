import csv
import re
import os

input_csv_path = "/home/victoria/training_data/combined_training_data_rogaland/combined_training_data_rogaland.csv"
output_csv_path = "/home/victoria/training_data/combined_training_data_rogaland/combined_training_data_cleaned_rogaland.csv"
new_audio_directory = "/home/victoria/training_data/combined_training_data_rogaland/resampled_sound_clips"

def clean_text(text):
    text = re.sub(r'[^A-Za-zÆØÅæøå\s]', '', text)
    text = re.sub(r'\s+', ' ', text).strip()
    return text


with open(input_csv_path, mode='r', encoding='utf-8') as input_file, \
     open(output_csv_path, mode='w', newline='', encoding='utf-8') as output_file:
    
    reader = csv.DictReader(input_file, delimiter='|')
    writer = csv.DictWriter(output_file, fieldnames=reader.fieldnames, delimiter='|')
    
    writer.writeheader()
    
    for row in reader:
        # Update the audio path to point to the new directory
        old_audio_path = row['audio_path']
        new_audio_path = os.path.join(new_audio_directory, os.path.basename(old_audio_path))
        row['audio_path'] = new_audio_path

        # Clean the transcription text
        row['transcription'] = clean_text(row['transcription'])
        
        # Write the cleaned row to the output file
        writer.writerow(row)

print("CSV file cleaned and saved to", output_csv_path)
