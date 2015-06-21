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



while getopts “hls:” OPTION
do
  case $OPTION in

    h)
      # print usage
      printUsage
      exit

    ;;
    # -l returns all notes
    # print in tree format??
    l)
      # list all files 1 per line
      # pipe to fpp to select files
      ls -d -1 $BASE/**/* | fpp
      exit
    ;;

    # -s <string> searches for all
    # return list of options
    s)
      # search file names
      ls -R $BASE | grep "$OPTARG"

      # search in files
      grep "$OPTARG" $BASE -R

      exit
    ;;

    # -n <string> makes a new note


    # -f <string> tree output of a subfolder

  esac
done

printUsage
