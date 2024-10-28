import os
from pydub import AudioSegment

base_path = "/home/victoria/training_data"

folders = [
    "foldereid_data", "gauldal_data", "namdalen_data", "oppdal_data", 
    "oppdal_data_ndc", "trondheim_data", "trondheim_data_ndc", "vikna_data"
]

total_duration = 0

def format_duration(milliseconds):
    seconds = int(milliseconds / 1000)
    minutes = seconds // 60
    hours = minutes // 60
    return f"{hours:02}:{minutes % 60:02}:{seconds % 60:02}"

for folder in folders:
    sound_clips_path = os.path.join(base_path, folder, "sound_clips")
    
    if not os.path.isdir(sound_clips_path):
        print(f"Sound clips folder not found in {folder}. Skipping...")
        continue
    
    folder_duration = 0
    
    for filename in os.listdir(sound_clips_path):
        if filename.endswith(".wav"):
            file_path = os.path.join(sound_clips_path, filename)
            audio = AudioSegment.from_wav(file_path)
            duration_ms = len(audio)  
            folder_duration += duration_ms
    
    print(f"Total duration for {folder}: {format_duration(folder_duration)}")
    total_duration += folder_duration

print(f"\nOverall total duration: {format_duration(total_duration)}")
