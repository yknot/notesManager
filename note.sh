#!/bin/bash


# open config files
# read in base folder
BASE=$(<base.config)
# read in text editor
EDITOR=$(<editor.config)

# print usage function
printUsage() {
echo "Usage: note
  list - list all notes
  search <string> - searches all notes for the string
"
}

# case statement args
if [ "$1" = "" ]; then
  if [[ "$BASE" = "" ]]; then
    echo "Error with base.config file"
  fi
  if [[ "$EDITOR" = "" ]]; then
    echo "Error with editor.config file"
  fi

  printUsage
  exit
fi


case $1 in
  # -t returns all notes
  # print in tree format
  list)
    ls -R $BASE
    exit
  ;;

  # -g <string> searches for all
  # return list of options
  search)
    if [ "$2" = "" ]; then
      echo "Need search string"
      printUsage
      exit
    fi

    # search file names
    ls -R $BASE | grep "$2"

    # search in files
    grep "$2" $BASE -R


  ;;

  # -n <string> makes a new note


  # -f <string> tree output of a subfolder





  *)
    printUsage

  ;;
esac
