#

<< comment
Write a shell script to move all .txt files from the /source directory to the /destination directory. 
Ensure that if the /destination directory doesn’t exist, the script creates it.
comment

#!/bin/bash

source_location=~/Downloads/
destination=~/Desktop/txt-backup/

mkdir -p "$destination"

find "$source_location" -name '*.txt' -type f -exec mv {} "$destination" \;

echo "Copying complete"
