## PART 1
### User creation and permission assignment

Steps to follow : 
- Open the terminal and enter the following commands.

		$ sudo useradd  devuser
This command will create de user 'devuser'.
		$sudo passwd devuser
	This command will ask for a password for the user 'devuser'. Enter the a password,  and then reconfirm the password.

You just created  a user, now let´s create a group.

		$sudo groupadd  developers 
Now,  let´s assing the user 'devuser'  to the group 'developers'
		$sudo usermod -aG developers devuser

Now, let´s  create a directory 'opt/devproject', change the owner of the directory assing to devuser and the group developers.

		sudo mkdir opt
		sudo mkdir opt/devproject
		sudo chown devuser opt/devproject 

Finally,  we just need to change the directory permissions.

		chmod  755 opt/devproject



##PART 2
###System maintenance

#####Create the bash script file from scratch

Firstable, run the next command to create the bash script file

		nano system_maintenance.sh

Then,  copy the next script



#####Download the bash script file

Download the system_maintenance.sh, then run the next command to apply the system_maintenance.sh 
