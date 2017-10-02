#!/bin/bash
#--- Wallcat Picture Saver Script ---
#Made by Rafael Munoz
#@hellarafa

DIRECTORY="/Users/$USER/Pictures/Wallcat" #FULL ABSOLUTE PATH to the folder where to save pictures to.
re='^[0-9]+|[C]$'
ans='^[n{1}|y{1}]$'
folder="/Users/$USER/Library/Containers/cat.wall.Wallcat/Data/DownloadedImages/"

if [ ! -d $folder ]; then
    echo "Wallcat either hasn't been loaded or is not installed."
    echo "Exiting..."
    exit 1
fi

files=($(ls -d /Users/$USER/Library/Containers/cat.wall.Wallcat/Data/DownloadedImages/*)) 
files1=($(ls -d /Users/$USER/Library/Containers/cat.wall.Wallcat/Data/DownloadedImages/* | awk -F/ '{print $NF}')) #THIS IS TO ONLY GET THE FILE NAME TO SHOW

echo -e "\033[1m--------------------------------"
echo "| Save Wallcat Wallpaper Script |"
echo -e "--------------------------------\033[0m"
echo -e "Last Updated: 08-02-2017\n"
echo -e "Script works with Ver. 1.1.0 or newer." 
echo -e "@dustin made changes to his app as of Ver. 1.1.0.\n"
echo -e "As of today, there are \033[35m"${#files[@]}"\033[0m wallpaper(s) in your wallcat library available to save.\n"

echo -e "\033[35m"\#"\033[0m"  "\033[92mFILENAME\033[0m"
echo "--------------------"
for i in "${!files1[@]}"
do
    echo -e "\033[35m"$i"\033[0m" "\033[92m"${files1[$i]}"\033[0m"
done
echo -e "\n"
echo -e "Please type the NUMBER[\033[35m"\#"\033[0m] of the file you would like to save."
echo "Type C or anything else to CANCEL."
echo -n "#NUMBER> "
read -n 1 number
if ! [[ $number =~ $re ]]; then
    echo -e "\n\033[31mERROR: CANCELING....\033[0m" >&2; exit 1
fi
echo -e "\n"
if [ $number == C ]; then
    echo "CANCELING... Not gonna do anything."
    exit 1
fi

#CHECK IF SAVE FOLDER EXISTS
if [ ! -d "$DIRECTORY" ]; then
    echo "SAVE FOLDER DOES NOT EXIST"
    echo "Making save folder..."
    mkdir $DIRECTORY
fi

echo -e "Saving wallpaper in \033[4m$DIRECTORY\033[0m.\n"

#THE MAGIC
cp ${files[$number]} $DIRECTORY/${files1[$number]}.jpg

echo "Done..."
echo -e "\n"
echo -n "Would you like to open the SAVE folder? (y/n): "
read -n 1 answer
if ! [[ $answer =~ $ans ]]; then
    echo "\n UHHH...I'll take that as a no..."
    exit 1
fi
if [ $answer = y ]; then
    echo -e "\n"
    echo "Goodbye."
    open $DIRECTORY
    exit 1
fi
if [ $answer = n ]; then
    echo -e "\n"
    echo "Goodbye."
    exit 1
fi 
