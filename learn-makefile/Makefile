# Syntax
# target-name1:
#	command1
#	command2
# target-name2
#	command1
#	command2

# targets are our own names as per requirement.

one:
	echo Hello - One
# This syntax will print command then output

two:
	@echo Hello - Two
# This syntax will print only output

# Make supports only tabs spaces in indentation, simple spaces will not help

git-pull:
	git pull

three: git-pull
	echo Hello - Three

four:
	echo Hello - Four-1
	make git-pull
	echo Hello - Four-2

five:
	echo Input - $(input)