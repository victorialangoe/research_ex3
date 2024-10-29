import os
import librosa
import soundfile as sf

input_directory = "/home/victoria/training_data/combined_training_data/sound_clips"
output_directory = "/home/victoria/training_data/combined_training_data/resampled_sound_clips"
os.makedirs(output_directory, exist_ok=True)

target_sr = 22050

for filename in os.listdir(input_directory):
    if filename.endswith(".wav"):
        filepath = os.path.join(input_directory, filename)
        y, sr = librosa.load(filepath, sr=None) 

        if sr != target_sr:
            y = librosa.resample(y, orig_sr=sr, target_sr=target_sr)
            print(f"Resampled {filename} from {sr} Hz to {target_sr} Hz")
        else:
            print(f"{filename} is already at the target sample rate of {target_sr} Hz")

        output_path = os.path.join(output_directory, filename)
        sf.write(output_path, y, target_sr)
