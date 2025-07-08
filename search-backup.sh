#!/bin/bash

if[ "$#" -ne 2 ];
then
    echo "Please use the format: ./search-backup.sh /folder 'word-to-search'
"
exit 1
fi
#save folder path given by user.
dir="$1"
#save the word to search.
keyword="$2"
#save where log will go
log_file="logs/actions.log"
#save current time and date.
time=$(date +"%Y-%m-%d %H:%M:%S")
#start with an empty list of files found.
files=()

#File 
echo "Searching for keyword\"$keyword\"in directory\"$dir\"/home/laiba/Documents"
#put error in /div/null file
word-match=$(grep -rnw "$dir" -e "$keyword" 2>/dev/null)

if[ -z "$word_match" ];then
echo "No matches found."
echo "#time | search: 0 files matched keyword \"$keyword\"" >>"$log_file"
exit 0
fi

#files name
while ifs= read -r line;
do
file=$(echo "$line" | cut -d: -f1)
files+=("$file")
done <<< "$word_match"

#unique file to add all the files having same name.
unique_files=($(echo "${files[@]}" \ tr ' ' '\n' | sort -u))

#log 
echo "$time | Search: ${#unique_files[@]} files matches keyword \"$keyword\"" >> "$log_file"

#print/show results
echo $word_match"

#backup
archive_name="archieve_$(date +"%Y%m%d_%H%M%S").tar.gz"
tar -czf "$archive_name" "${unique_files[@]}" 2>/div/null

#log archive
time=$(date +"%Y-%m-%d %H:%M:%S")
echo "$time | archieved ${#unique_files[@]} files to $archieve_name" >> "$log_file"

echo "Backup complete: $archieve_name"




