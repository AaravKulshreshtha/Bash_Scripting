#!/bin/bash

# Write a Bash  script that declares a variable named "name" and assign it the value " Marcela". Print the value of the variable to the terminal.

name="Marcela"

echo "hello welcome  $name "


# Write a Bash script that declares two variables, "firstName" and "lastName", and assign them your first name and last name, respectively. Print a message greeting yourself using variable interpolation.

firstName="Anshul"
LastName="Kulshreshtha"

echo "Hello welcome back Mr. $firstName $LastName"

# Write a Bash script that declares a variable named "age" and assign it your age. Print a message including your age.

age=20

echo "Hello My age is $age"

#Write a Bash script that prompts the user to input their favorite mobile. Store the input in a variable named "mobile" and display a message including their favorite mobile
<<COMMENT
echo "Enter your Mobile_No"

read Mobile

echo "My Favourite Mobile no is $Mobile"
COMMENT
#Write a Bash script that declares two variables, "var1" and "var2", and assign them two different words. Concatenate the variables and print the result.

name="Anshul"
last="Kulshreshtha"

echo "$name  $last"

# Write a Bash script that declares a variable named "x" and assign it a numeric value. Then, reassign it to a different value and print the updated value.

x=200

echo "value of x before reassignment is $x"

x=300

echo "value of x after reassignment is $x"

#Write a Bash script with a variable declared inside a function. Try to access the variable outside the function and observe the result.

anshul(){
    fullname="Anshulkulshreshtha"
    echo "my name is $fullname"
}

anshul

echo "my full name is $fullname"


#Write a Bash  script that uses command substitution to store the output of the datetime command in a variable named "currentDateTime". Print the value of "currentDateTime".

current_datetime=$(date)

echo "Current date time is $current_datetime"

#Write a Bash script that declares an array named "colors" containing the names of your favorite colors. Print the entire array.

colors=("Red" , "Blue"  "Black"  "Green")

echo "My favourite color is ${colors[@]}"

#Write a Bash script that utilizes special variables like $0, $#, $@, and $? in a script and display their values.

echo  "currently running script name $0"

echo "$#"

echo "$@"

echo "$?"

# Write a Bash script that redirects the output of the ls command to a file named "test.txt". Print the content of list.txt.
echo "Output redirection"

ls > test.txt

# Write a Bash script that uses  input redirection to read the contents of a file named "exec_stderr.txt" and then echoes those contents to the terminal.

echo "Input redirection"

cat < test.txt

#Write a Bash script that uses both input and output redirection to read the contents of a file named "input.txt" and write them to a new file named "output.txt".

ls > input.txt

cat < input.txt 

input.txt > output.txt

cat < output.txt 