#!/bin/bash

#(#represents number of arguments pass)
if [ "$#" -ne 2 ]
then
     echo "Number of arguments should be 2"
     exit 1
fi

dir="$1"   #first argument 
keyword="$2"    #second argument

log_file="log/log_actions.log"
#log_file stores,search and backup all activities

mkdir -p log

time=$(date +"%Y-%m-%d %H:%M:%S")
#format to get current date or time

files=()     #empty array

#print that it search for the given word in given directory
echo "searching for Keyword \"$keyword\" in directory \"$dir\""

#search the given word in given directory and hide if any error happens
word_match=$(grep -rnw "$dir" -e "$keyword" 2>/dev/null)

#if no match is found then exit and log the result
if [ -z "$word_match" ]
then 
     echo "no words match(empty)"
     echo "$time | search: 0 files matched keyword \"$keyword\"" >> "$log_file"
     exit 0
fi

#it read one line, gets the file name from grep and add it in files
while IFS=read -r line;
do
   file=$(echo "$line" | cut -d: -f1)
   files+=("$file")
done <<< "$word_match"

#turn space separated list one per line and sort and remove duplicate
unique_files=($(echo "${files[@]}" | tr ' ' '\n' | sort -u))

#count all unique files and append log input
echo "$time | Search: ${#unique_files[@]} files matches keyword \"$keyword\"" >> "$log_file"

#print matched word
echo "$word_match"

#make unique name
archive_name="archive_$(date +"%Y%m%d_%H%M%S").tar.gz"

#archive
tar -czf "$archive_name" "${unique_files[@]}" 2>/dev/null

#logs archive operation
time=$(date +"%Y-%m-%d %H:%M:%S")
echo "$time | archived ${#unique_files[@]} files to $archive_name" >> "$log_file"

#print backup done
echo "Backup done successfully: $archive_name"
