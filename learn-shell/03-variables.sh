#If we assign a name to a set of data it is called as variable

#Syntax: var=data

x=10
y=Hello

#Access a variable
#Syntax: $var or ${var}

echo x - $x
echo x - ${x}


# Variables are used to avoid repetition. Meaning if we have some data that needs to be used in many places in a the script, we declare that as a variable
# then will access that variable. Any situation the data needs to be changed, we change in one place, it changes in all places (where it appears).

# Naming Convention for variables
# Alphabets, a-z, A-Z, numbers, underscore

#Variable Types
#Shell does not have any variable type by default
# Every variable is a string. Not in, long characters, booleans

#Input Variables
#                         <Variable Input>
#   <Variable Input>            script        <Variable Input>

#                       Environment from CLI
#   LHS                     script                RHS

echo z - $z
#ABOVE LHS (LEFT HAND SIDE)

# LHS - z=20 bash 03-variables.sh
# As an Environment Variable - export z=30; bash 03-variables.sh
# RHS - bash 03-variables.sh 40

n=$1
echo n - $n
#ABOVE RHS (RIGHT HAND SIDE)

#rhs - Special Variables
# bash script 100 200 300
# $0 - script
# $1 - 100
# $2 - 200
# $3 - 300.....likewise we can go for $n
# $* - 100 200 300 - All Inputs
# $# - 3 - Number of Inputs

# So far the input is provided, wither by hardcoding, or by user from cli
#  At times we need to declare the variables dynamically

# Dynamic Variables
# 1. Command Substitution
# Syn: var=$(command)
DATE=$(date)
echo Today Date - $DATE

#2. Arithmetic Substitution
# Syn: var=$((arithmetic expression))

ADD=$((100+200))
echo Add of 100 + 200 is $ADD
