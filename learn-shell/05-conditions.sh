# if condition
# case condition
# if condition is the widely used one in shell. Its alternative case command have basic functionality. Hence, it is not that much preferred

# if condition can be made in three forms

# 1 Simple IF

Syntax:
if [ expression ]; then
# commands
#fi

@ 2. If-Else

#Syntax
#if [ expression ]; then
#   commands-x
#else
#   commands-y
#fi

# commands-x will run if expression is true, else it will run command-y

# 3. Else-IF

#syntax:
#if [ expression1 ]; then
#   commands
#elif [ expression2 ]; then
#   commands
#......... can go for expression-n
#else
#   commands
#fi

# which ever expression is true, it is associated commands will be executed.x


#####################
# In every place we are seeing expressing is been used
# Following expressions are used

# 1.    Number expressions
# Operators: -eq, -ne, -ge, -gt, -lt, -le

# [ 1 -eq 1 ] - This is true or false will be validated by shell

# 2.    String expressions
# Operators: ==, !=, -z, -n
# [ abc == xyz]
# [ -z "$x" ]  - True if x is empty
# [ -n "$x" ]  - True x is not empty

# 3.    File expressions
# Operators: -e
# [ -e new.txt ] -> True if next.txt exists
# https://www.tutorialspoint.com/unix/unix-file-operators.htm

amount=$1
currency=$2

if [ "$currency" == "usd" ]; then
    inr=$(($1*85))
    echo currency in INR - $inr
fi

if [ "$currency" == "aud" ]; then
    inr=$(($1*55))
    echo AUD currency in INR - $inr
fi



