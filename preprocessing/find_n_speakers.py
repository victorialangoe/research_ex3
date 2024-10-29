# Define the range of valid speaker IDs
VALID_SPEAKER_IDS = range(39)

# File paths to check
file_paths = [
    "/home/victoria/training_data/combined_training_data/matcha_training_data/matcha_data_train.txt",
    "/home/victoria/training_data/combined_training_data/matcha_training_data/matcha_data_val.txt"
]

# Function to parse and check each line for speaker ID consistency
def check_speaker_ids(file_path):
    invalid_ids = []
    with open(file_path, 'r') as file:
        for line_number, line in enumerate(file, start=1):
            # Split line based on the known format: audio_file_path|speaker_id|text
            parts = line.strip().split("|")
            
            # Ensure the line has exactly three parts
            if len(parts) != 3:
                print(f"Unexpected format on line {line_number} in {file_path}: {line.strip()}")
                continue
            
            # Attempt to parse the speaker_id as an integer
            try:
                speaker_id = int(parts[1])  # Speaker ID should be the second part
                # Check if the speaker ID is within the valid range
                if speaker_id not in VALID_SPEAKER_IDS:
                    invalid_ids.append((line_number, speaker_id))
            except ValueError:
                print(f"Error parsing speaker ID on line {line_number} in {file_path}: {parts[1]}")
    
    # Report results
    if invalid_ids:
        print(f"Found invalid speaker IDs in {file_path}:")
        for line_num, invalid_id in invalid_ids:
            print(f"  - Line {line_num}: Invalid Speaker ID {invalid_id}")
    else:
        print(f"All speaker IDs in {file_path} are within the valid range.")

# Run the check for each file
for path in file_paths:
    check_speaker_ids(path)
