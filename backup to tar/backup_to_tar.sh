#!/bin/bash
# This script aims at maintaining backups for all files/directories listed below
# Tested on Debian Jessie only
# Use for backup on my test files. Run from /path/to/directory/

# Files/directories being backed are
# file.jsp
# file2.jsp
# file3.jsp
# directory

# Checks that the correct user is executing the script; returns error and stops if not
if [ "$(whoami)" != 'user' ]; then
        echo "Must be user to run $0"
        exit 1;
fi

# Contains all files the script will copy to backup directory
files_array=(file.jsp file2.jsp file3.jsp directory)

# Gets the date for backup directory name
date_value=$(date '+%Y-%m-%d')

# Path to backup directory
path='/home/'$USER'backup'

# Current working directory
current_path=$(pwd)

# Test for existing backup directory
if [ -f "$path/$date_value.tar.gz" ] ; then
# If backup direcotry exist, do
	echo "A $date_value.tar.gz directory already exist."
	echo "Do you wish to update existing directory ? (y/n)"
	
USER_INPUT=0

	read -n 1 -r USER_INPUT
	
	echo # Carriage return
	
	case $USER_INPUT in

# Case when user answers "Y" or "y" (Yes), do
	Y|y) echo "Extracting archive"
	
	tar xf "$path/$date_value.tar.gz" 
	
	echo "Updating files"
	rsync --update -raz --progress \
	      --include="$current_path${files_array[*]}" "$path/$date_value" \
	      --exclude="*"
	
	exit 0;
	;;
	
# Case when user answers anything else, do
	*) echo "Didn't update directory"
		exit 1;
	esac
	
# Else if backup directory doesn't exist yet
else
# Make a directory using the date
	mkdir "$path/$date_value"

# Loops over the whole array and copy files/directories recursively to given directory with current rights
	for i in "${files_array[@]}" ; do
		cp -ar "${i}" /home/robin/backup/by_date/"$date_value"/
	done

# Goes to backup directory
	cd "$path" || return

# Compress backup directory into tarball AND(=&&) removes it if successfull
	echo "Compressing directory to $date_value.tar.gz"
	echo "Removing $date_value uncompressed directory"
	tar cfM "$date_value.tar.gz" "$date_value" && rm -Rf "$date_value"

fi
