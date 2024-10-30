import os
import wave

directory = "/home/victoria/training_data/combined_training_data_rogaland/resampled_sound_clips"

unique_sample_rates = set()

for filename in os.listdir(directory):
    if filename.endswith(".wav"):
        filepath = os.path.join(directory, filename)
        try:
            with wave.open(filepath, 'r') as file:
                sample_rate = file.getframerate()
                unique_sample_rates.add(sample_rate)
        except wave.Error as e:
            print(f"Could not process {filename}: {e}")

print("Unique sample rates found:")
for sr in unique_sample_rates:
    print(f"{sr} Hz")


