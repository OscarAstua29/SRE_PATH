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


## PART 2
### System maintenance
#### Create the bash script file from scratch


Firstable, run the next command to create the bash script file

		nano system_maintenance.sh

Then,  copy the next script:

		#!/bin/bash

		output_file=maintenance_output.txt

		echo -e "MAINTENANCE OUTPUT" >> $output_file
		echo -e $(date) >> $output_file
		echo -e "-------------------------------------------------------" >> $output_file

		sudo apt-get update >> $output_file

		echo -e "-------------------------------------------------------" >> $output_file
		echo -e "System updated" >> $output_file
		echo -e "-------------------------------------------------------" >> $output_file

		sudo apt-get autoremove -y >> $output_file
		sudo apt-get clean >> $output_file

		echo -e "Unnecesary data deleted" >> $output_file
		echo -e "-------------------------------------------------------" >> $output_file
		echo -e "State of ROM " >> $output_file

		df -h >> $output_file

		echo -e "-------------------------------------------------------" >> $output_file
		echo -e "Active Users " >> $output_file

		who >> $output_file

		echo -e "-------------------------------------------------------" >> $output_file
		echo -e "Top 5 proccess that consume most CPU " >> $output_file

		ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6 >> $output_file

		echo -e "-------------------------------------------------------" >> $output_file
Use command ctrl + o to write out the file
Use command ctrl + x to exit

### Download the bash script file.

Download the system_maintenance.sh on your computer.


Finally, run the next command to assing the execution permission to the system_maintenance.sh file :

		chmod +x system_maintenance.sh

To run the system_maintenance.sh  file, run the next command

		./system_maintenance.sh 
