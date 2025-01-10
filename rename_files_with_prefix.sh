# Rename .txt Files by Adding a Prefix

<<comment
Write a shell script that renames all .txt files in a given directory by adding a prefix to the filename. 
The prefix should be provided as an argument to the script.

For example:
If the script is run with the prefix backup_, a file named file1.txt should be renamed to backup_file1.txt.
comment

#!/bin/bash

folder_path=~/Desktop/txt-backup/
prefix=backup_

if [ ! -d "$folder_path" ]; then
    echo "The directory $folder_path does not exist."
    exit 1
fi

find "$folder_path" -name '*.txt' -type f | while IFS= read -r file; do
    base_name=$(basename "$file" .txt)  
    mv "$file" "$folder_path/$prefix$base_name.txt"  
done

echo "Files renamed successfully."
