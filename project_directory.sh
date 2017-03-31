#!/bin/bash
# This script aims at maintaining backups for project directory.
# Kind of a very very very (very) basic versionning system.
# Use for backup on my project files. Run from project directory.
# For simplicity, add a 'sback' alias in your .bashrc or shell config file.

# Checks that the correct user is executing the script; returns error and stops if not.
# 'user' must be switched with a user having writing rights on directory (and files for recursivity).
if [ $(whoami) != 'user' ]; then
        echo "Must be user to run $0"
        exit 1;
fi

# Gets path to current directory.
current_directory=$(pwd)

# Gets the date for backup directory name.
date_value=$(date '+%Y-%m-%d')

# Make a directory using the date.
mkdir /home/"$USER"/backup/directory/"$date_value"

# Copy directory and files recursively to set directory withcurrent rights
cp -ar "$current_directory" /home/"$USER"/backup/by_date/"$date_value"/

# Compress backup directory into tarball, and if successful, remove uncompressed directory.
tar -cf /home/"$USER"/backup/by_date/"$date_value".tar.gz "$current_directory" && rm -Rf /home/"$USER"/backup/by_date/"$date_value"/

exit 0
