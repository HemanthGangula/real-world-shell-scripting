# Count and List All .txt Files in a Directory and Subdirectories

<< comment
Write a shell script that counts and lists all the .txt files in a given directory and its subdirectories. 
The script should:

1. Count how many .txt files exist.
2. List the paths of all .txt files.
3. Print a message with the total count and list of files.
comment


#!/bin/bash

folder_path=~/Desktop/txt-backup/
count=0

# Iterate over all .txt files found by the find command
for file in $(find "$folder_path" -name '*.txt' -type f); do
    echo "$file"  # Print each file path
    count=$((count + 1))  # Increment count
done

# Print the total count of .txt files
echo "Total .txt files in $folder_path: $count"


