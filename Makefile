all : commands

## commands   : show all commands.
commands :
	@grep -E '^##' Makefile | sed -e 's/## //g'

## build      : build HTML files.
build : 
	jekyll build

## clean      : clean up junk files.
clean :
	rm -rf _site
	find . -name '*~' -exec rm {} \;
	find . -name .DS_Store -exec rm {} \;
