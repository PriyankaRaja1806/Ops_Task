#!/bin/bash
mkdir -p /home/priyanka/my_personal_diary

current_date=$(date +%F)

if [ "$1" == "current" ]; then
diary_date=$current_date
else
random_days=$(( RANDOM % 365 ))
diary_date=$(date -d "-$random_days days" +%F)
fi

diary_file="/home/priyanka/my_personal_diary/$diary_date.txt"

if [ ! -f "$diary_file" ]; then
touch "$diary_file"
echo "My diary for $diary_date created: $diary_file"
else
echo "My diary for $diary_date already exists."
fi

# Get user input for the diary entry
echo "Write your diary entry for $diary_date (press Enter when done):"
read diary_entry

# Save the entry with a timestamp
echo "[$(date '+%H:%M:%S')] $diary_entry" >> "$diary_file"

echo "Your entry has been saved in $diary_file"
