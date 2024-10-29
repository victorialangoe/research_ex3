import pandas as pd
from sklearn.model_selection import train_test_split

csv_file = "/home/victoria/training_data/combined_training_data/combined_training_data_cleaned.csv"
df = pd.read_csv(csv_file, delimiter='|')

unique_speakers = df['speaker'].unique()
speaker_mapping = {speaker: idx + 1 for idx, speaker in enumerate(unique_speakers)}
df['speaker'] = df['speaker'].map(speaker_mapping)

df = df[['audio_path', 'speaker', 'transcription']]

train_df, val_df = train_test_split(df, test_size=0.1, random_state=1234)

train_filelist = "/home/victoria/training_data/combined_training_data/matcha_training_data/matcha_data_train.txt"
val_filelist = "/home/victoria/training_data/combined_training_data/matcha_training_data/matcha_data_val.txt"

train_df.to_csv(train_filelist, sep='|', header=False, index=False)
val_df.to_csv(val_filelist, sep='|', header=False, index=False)

print(f"Training and validation filelists created at {train_filelist} and {val_filelist}")
print(f"Number of unique speakers: {len(unique_speakers)}")
print("Speaker mapping (original ID -> numeric ID):")
print(speaker_mapping)
