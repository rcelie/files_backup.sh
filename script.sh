#!/bin/bash
# This script aims at maintaining backups for all files/directories listed below
# Kind of a very very very (very) basic versionning system
# Use for backup on my test files. Run from /path/to/directory/

# Files/directories being backed are
# file.jsp
# file2.jsp
# file3.jsp
# directory

# Checks thaht the correct user is executing the script; returns error and stops if not
if [ $(whoami) != 'user' ]; then
        echo "Must be user to run $0"
        exit 1;
fi

# Contains all files the script will copy to backup directory
files_array=(file.jsp file2.jsp file3.jsp directory)

# Gets today's date for backup directory name
date_value=$(date '+%Y-%m-%d')

# Make a directory using today's date
mkdir /path/to/backup/directory/"$date_value"

# Loops over the whole array and copy files/directories recursively to given directory with current rights
for i in ${files_array[@]}; do
		cp -ar ${i} /home/robin/backup/by_date/"$date_value"/
done
exit 0
