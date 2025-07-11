Intern_2025</br> 
Week 01 project</br> 
This is BASH Script that:</br> 
->Search for keyword in files.</br> 
->Logs tha result.</br> 
->Create backup of matched files.</br> 

Linux commands used:</br> 
grep: To search for the keyword in files.</br> 
cut: To extract filenames from the grep output.</br> 
mkdir: To create a logs directory.</br> 
tar: To create compressed backups.</br> 
date: To generate timestamps for logging and archive names.</br> 
tr, sort, uniq: To clean and deduplicate the list of matching files.</br> 
echo, exit: For output and script control.</br> 

Working:</br> 
->Search for keyword.</br> 
->show file name that matches.</br> 
->create zip file of match files.</br> 
->Log all actions.</br> 

Folder/Directory:</br> 
->./search-backup.sh /home/laiba/file-manager "error"</br> 
