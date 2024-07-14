
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

echo -e "-------------------------------------------------------" >> $output_file


