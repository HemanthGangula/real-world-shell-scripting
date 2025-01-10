# Backup .log Files with Date in Filename

<<comment
Write a shell script to create a backup of all .log files in a directory. The script should move the .log 
files to a backup folder, appending the current date to each file's name.

For example:
If the file is error.log, the backup should be named error-YYYY-MM-DD.log in the backup directory.
comment

#!/bin/bash

source_location=~/Downloads/
destination=~/Desktop/log-backup/

mkdir -p "$destination"

current_date=$(date +%Y-%m-%d)

for file in $(find "$source_location" -name '*.log' -type f); do
    base_name=$(basename "$file" .log)
    
    mv "$file" "$destination/${base_name}-$current_date.log"
done

echo "Successfully moved and renamed log files to $destination"
