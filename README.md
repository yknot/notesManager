# Notes Manager

## Setup
* Set `NOTE_CONFIG` environment variable to path to your config files
* Create `base.config` to contain the base path to your notes
	* Ex: `/Users/yknot/notes`
* Create `editor.config` to contain the command to use for your editor of choice
	* Ex: `open -a Mou`
* *Optional* - add alias for n to be note or add note folder to your path



## Usage

	Usage: note
	  -h - print this message
	  -l - list all notes
	  -s <string> - searches all notes for the string
	  -f <string> -n <string> - create new note with path -f and name -n
	  -d <string> - delete note given relative path
	  
* `-l` - List uses Facebook path picker (`fpp`) and `tree` to display the files
* `-s` - Search will search all note titles and contents. It returns a list of all matched files
* `-f` `-n` - Create new file on base path plus `-f` path, with file name `-n`
* `-d` - Delete file with path base plus `-d`





### TODO
* Better way to create and delete notes