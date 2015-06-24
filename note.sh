#!/bin/bash


# open config files
# read in base folder
BASE=$(<base.config)
# read in text editor
EDITOR=$(<editor.config)

# print usage function
printUsage() {
echo "Usage: note
  -h - print this message
  -l - list all notes
  -s <string> - searches all notes for the string
  -f <string> -n <string> - create new note with path -f and name -n
"
}
# standard list all function
listFiles() {
  # list all files in tree format
  # pipe to fpp to select files

  # print in tree format
  tree -f --charset=ascii $BASE | fpp
}

# make sure editor and base are set
if [[ "$BASE" = "" ]]; then
  echo "Error with base.config file"
  printUsage
  exit 1
fi
if [[ "$EDITOR" = "" ]]; then
  echo "Error with editor.config file"
  printUsage
  exit 1
fi



# loop through all flags and their args
while getopts “hls:f:n:” OPTION
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

    # -n <string> makes a new note
    n)

      if [[ $folder = "" ]]; then
        echo "Specify folder first"
        exit 1
      fi
      # create new file with name given
      d=$(date "+%Y-%m-%d")
      touch $BASE/$folder/$d-$OPTARG.md
      $EDITOR $BASE/$folder/$d-$OPTARG.md

      exit
    ;;

    # -f <string> tree output of a subfolder

  esac
done


listFiles
