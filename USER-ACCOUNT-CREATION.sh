#USER-ACCOUNT-CREATION


#!/bin/bash

#Scripts should be executed with just sudo/root access

if [[ "${UID}" -ne 0 ]]
then
echo "Please run with sudo or root"
exit 1
fi

#User Should provide atleast one argument as Username else Guide him
if [[ "${#}" -lt 1 ]]
then
echo "Usage: ${0} USERNAME [COMMENT]..."
echo "Create a user name USER_NAME and comments fields of commnets"
exit 1
fi
#store 1st argument as username
USER_NAME="${1}"

#In case of more than one argument,store it as account Commnets
shift
COMMENT="${@}"
echo $COMMENT
#Create Password

PASSWORD=$(date +%s%N)
#Check if user is Successfully created or not

#Create the user
useradd -c "${COMMENT}" -m $USER_NAME


#Check if user is Successfully created or not

if [[ $? -ne 0 ]]
then
echo "The Account could not be created"
exit 1
fi

#set the password for the user
echo $PASSWORD | passwd --stdin $USER_NAME
#check if password is successfully set or not

if [[ $? -ne 0  ]]
then
echo "Password could not be created "
exit 1
fi


#force Password change on first login
passwd -e $USER_NAME

#display

echo
echo "Username : $USER_NAME"
echo
echo "Password : $PASSWORD"
echo
echo $(hostname)

