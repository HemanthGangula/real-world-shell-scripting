# Append Timestamp to Log Files in a Directory

<< comment
Write a shell script to append the current timestamp to the name of each .log file in a given directory. 
For example, if the file is named error.log, it should be renamed to error_20250108_123456.log, 
where the appended part is the current date and time in YYYYMMDD_HHMMSS format.
comment

#!/bin/bash

folder_path=~/Desktop/logtest/

if [ ! -d "$folder_path" ]; then
    echo "'$folder_path' doesn't exist"
    exit 1
fi

find "$folder_path" -name '*.log' -type f | while IFS= read -r file; do 
    current_date=$(date +%Y%m%d)
    current_time=$(date +%H%M%S)
    base_name=$(basename "$file" .log)
    mv "$file" "$folder_path/${base_name}_${current_date}_${current_time}.log"
done

echo "Updated timestamps successfully."