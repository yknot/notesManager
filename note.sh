#!/bin/bash

# print usage function
printUsage() {
echo "Usage: note
  -h - print this message
  -l - list all notes
  -s <string> - searches all notes for the string
  -f <string> -n <string> - create new note with path -f and name -n
  -d <string> - delete note given relative path
"
}
# standard list all function
listFiles() {
  # list all files in tree format
  # pipe to fpp to select files

  # print in tree format
  tree -f --charset=ascii $BASE | fpp
}
# ask for confirmation
ask() {

  # ask for confirmation
  read -p "$1 [y/n] " REPLY

  # default to no
  if [ -z "$REPLY" ]; then
    REPLY="n"
  fi

  # 0 is true in bash
  case "$REPLY" in
    Y*|y*) return 0 ;;
    N*|n*) return 1 ;;
  esac
}

# open config files
# read in base folder
BASE=$(<base.config)
# read in text editor
EDITOR=$(<editor.config)

# make sure editor and base are set
if [[ "$BASE" = "" ]]; then
  echo "ERROR: Can't open base.config file"
  printUsage
  exit 1
fi
if [[ "$EDITOR" = "" ]]; then
  echo "ERROR: Can't open editor.config file"
  printUsage
  exit 1
fi


# loop through all flags and their args
while getopts “hls:f:n:d:” OPTION
do
  case $OPTION in

    h)
      # print usage
      printUsage
      exit

    ;;
    # -l returns all notes
    l)
      # call list function
      listFiles
      exit
    ;;

    # -s <string> searches in all notes
    # return list of options
    s)
      # search file names and ouput to file
      ls -d -1 $BASE/**/* | grep "$OPTARG" > .out

      # search in files and append to .out
      grep "$OPTARG" $BASE -R >> .out

      # fpp for .out
      cat .out | fpp

      # clean up
      rm .out

      exit
    ;;

    # -f <string> set the folder to put new note in
    f)
      folder=$OPTARG
    ;;

    # -n <string> set the filename for the new note
    n)
      note=$OPTARG
    ;;

    # -d <string> delete note at path
    d)
    # create path
     path=$BASE/$OPTARG
     # ask to confirm delete
     if ask "Do you want to delete $path?" ; then
      rm $path
       echo "$path was deleted"
     else
       echo "$path was not deleted"
     fi

     exit
    ;;
  esac
done


# if not making new file then list files
if [ "$folder" = "" ] && [ "$note" = "" ]; then
  # folder and note == ""

  listFiles
  exit

# if make new file and both values are there
elif [ "$folder" != "" ] && [ "$note" != "" ]; then
  # folder and note != ""

  # create new file with date prefix in folder given
  d=$(date "+%Y-%m-%d")
  touch $BASE/$folder/$d-$note.md
  $EDITOR $BASE/$folder/$d-$note.md
  exit

else
  # if no folder name
  echo "ERROR: Specify folder and note"
  printUsage
  exit 1

fi
