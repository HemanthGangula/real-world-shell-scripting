# Archive .log files from a folder into a .tar.gz file with a timestamp.

<<comment
Write a shell script to search for all .log files in a given folder and its subdirectories. 
Archive them into a compressed .tar.gz file, adding a timestamp to the archive name. The script should:

- Check if the specified folder exists.
- Create an archive with the name logs_backup_<current_date_time>.tar.gz.
- Only include .log files in the archive.
- Exclude the archive itself if it is created in the same folder.
comment

#!/bin/bash

log_folder=~/Desktop/logtest

if [ ! -d "$log_folder" ]; then
    echo "'$log_folder' doesn't exist."
    exit 1
fi

echo "Archiving log files from '$log_folder'..."

current_date=$(date +%Y%m%d)
current_time=$(date +%H%M%S)
file_name="$log_folder/logs_backup_${current_date}_${current_time}.tar.gz"


if find "$log_folder" -maxdepth 1 -name '*.log' -print0 | tar --null -czvf "$file_name" --files-from -; then
    echo "Archive '$file_name' created successfully."
else
    echo "Failed to create archive."
fi
