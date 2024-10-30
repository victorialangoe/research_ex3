import os
import csv
import shutil

base_path = "/home/victoria/training_data"

folders = [
    "aasane_data","arna_data","bergen_data","bergen_data_ndc","boemlo_data","boemlo_data_ndc",
    "kalvaag_data","kvinnherad_data","fana_data","laksevaag_data"
]

combined_path = os.path.join(base_path, "combined_training_data_rogaland")
combined_sound_clips_path = os.path.join(combined_path, "sound_clips")
combined_csv_path = os.path.join(combined_path, "combined_training_data.csv")

os.makedirs(combined_sound_clips_path, exist_ok=True)

with open(combined_csv_path, mode='w', newline='', encoding='utf-8') as combined_csv_file:
    writer = csv.writer(combined_csv_file, delimiter='|')
    writer.writerow(["audio_path", "transcription", "speaker"])  

    seen_files = set()

    for folder in folders:
        sound_clips_path = os.path.join(base_path, folder, "sound_clips")
        csv_folder_path = os.path.join(base_path, folder, "csv")
        
        if not os.path.isdir(sound_clips_path) or not os.path.isdir(csv_folder_path):
            print(f"Skipping {folder} as required folders are missing.")
            continue

        csv_file_path = None
        for file_name in ["LIA_training_data.csv", "NDC_training_data.csv"]:
            potential_path = os.path.join(csv_folder_path, file_name)
            if os.path.isfile(potential_path):
                csv_file_path = potential_path
                break
        
        if csv_file_path is None:
            print(f"No valid CSV file found in {folder}. Skipping...")
            continue

        with open(csv_file_path, mode='r', encoding='utf-8') as csv_file:
            reader = csv.DictReader(csv_file, delimiter='|')
            
            for row in reader:
                original_audio_path = row["audio_path"]
                file_name = os.path.basename(original_audio_path)

                if file_name in seen_files:
                    print(f"Duplicate detected: {file_name} from folder {folder}")
                    continue 

                seen_files.add(file_name)

                original_wav_path = os.path.join(sound_clips_path, file_name)
                new_wav_path = os.path.join(combined_sound_clips_path, file_name)
                
                if os.path.exists(original_wav_path):
                    shutil.copy2(original_wav_path, new_wav_path)
                else:
                    print(f"File {original_wav_path} not found. Skipping.")
                    continue
                
                new_audio_path = f"/home/victoria/training_data/combined_training_data_rogaland/sound_clips/{file_name}"
                writer.writerow([new_audio_path, row["transcription"], row["speaker"]])

print("Data combined successfully into combined_training_data folder.")
