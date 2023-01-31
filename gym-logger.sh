#!/bin/bash
BRANCH_GIT="log"
NOW=$(date +"%A %d de %B - %Y")
LOG_FILE="gym-logs.txt"

if [ ! -e  ".git" ]; then
	echo " "
	echo "No repository found."
	echo " "
	read -p "Initialize git repository? [Y/n] " INITIALIZE_GIT

	if [[ $INITIALIZE_GIT = "n" || $INITIALIZE_GIT = "N" ]]; then
		echo "Okay, not initializing git repository!"

	else
		echo " "
		echo "Initializing git repository."
		read -p "Please add remote: " REMOTE_GIT
		command git init > /dev/null
		command git remote add origin $REMOTE_GIT
		command git checkout -B $BRANCH_GIT --quiet
		echo "Added remote $REMOTE_GIT. You can change it via git commands."
	   	echo " "
		command touch $LOG_FILE && git init && git add $LOG_FILE && git commit -m "Setting upstream" --quiet && git push --set-upstream origin $BRANCH_GIT --quiet && rm $LOG_FILE
		echo " "
		echo "Created repository. If something went wrong, work it out with the git CLI."
		echo " "
	fi
fi

read -p "Bench press: " BENCH_KG
read -p "Squat: " SQUAT_KG
read -p "Deadlift: " DEADLIFT_KG

EGO_ECHO="$NOW\n\nBench press: $BENCH_KG Kgs\nSquat: $SQUAT_KG Kgs\nDeadlift: $DEADLIFT_KG Kgs\n\n-----"

if test -f "$LOG_FILE"; then
	LAST_ENTRANCE=$(tail -7 gym-logs.txt)
	echo " "
	echo "Good! last entrance was: \n$LAST_ENTRANCE"
	echo " "
fi

command printf "$EGO_ECHO \n" >> gym-logs.txt

read -p "Push to GitHub? [Y/n] " PUSH_GH

if [[ $PUSH_GH = "n" || $PUSH_GH = "N"  ]]; then
	echo "Okay, not pushing!"

else
	command git checkout -B $BRANCH_GIT --quiet
	command git add $LOG_FILE && git commit -m "$NOW" --quiet
	command git push origin $BRANCH_GIT --quiet

	echo " "
	echo "Attempted to push. If something went wrong, work it out with the git CLI."
fi
