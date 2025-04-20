# If we have to iterate some commands again and again the we go for loops

# for   - if we have inputs
# while - if we have expressions

# expressions discussed on if condition, same expressions here for while loops
# syntax:

#while [ expression ]; do
#   commands
#done
#

#x=10
#while [ $x -gt 0 ]; do
#    echo loop in while command
#done

x=10
while [ $x -gt 0 ]; do
    echo loop in while command
    x=$(($x-1))
done

for fruit in apple banna orange; do
    echo Fruit Name - $fruit
done

for username in steve john raju; do
    echo Adding User - $username
done


