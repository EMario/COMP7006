#Author: Mario Enriquez
#A00909441
#BCIT COMP 7006

file_exists(){
	local f="$1"
	[[ -f "$f" ]] && return 0 || return 1
}

clear
set -f
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
DIR+="/mails/"
DATE=$(date)
option=0
min=*
hour=*
daym=*
month=*
dayw=*
while [ $option != 5 ]
do
echo "This is a shell that generates Cron scheduled mails"
echo "Please indicate what do you want to do:"
echo "1 to send an e-mail with attachments"
echo "2 to send an e-mail without attachments"
echo "3 to change the current CRON settings"
echo "4 to view current settings"
echo "5 to quit."
read option
if [ $option == 1 -o $option == 2 ]
then
	echo 'Please write the e-mail address:'
	read email
	echo 'Please write the message of the document'
	read body
	echo 'Please write the subject of the document'
	read subject
	echo $date
	if [ $option == 1 ]
	then
		echo 'Please write the mail to attach'
		read attachment
		if (file_exists "$attachment" )
		then
			#newfile=''
			#newfile+=$DIR
			#newfile+="crontask.sh"
			#touch $newfile
			#chmod 777 $newfile
			echo "$min $hour $daym $month $dayw $newfile root echo $body | mail -s "'"'"$subject"'"'" -a $attachment $email" >> /etc/crontab
			#echo "$min $hour $daym $month $dayw $newfile" | crontab
		else
			echo "File doesn't exist try again"
		fi		
	else
		echo "$min $hour $daym $month $dayw $newfile root echo $body | mail -s "'"'"$subject"'"'"  $email" >> /etc/crontab
	fi 
elif [ $option == 3 ]
then
	continue=0
	selection=0
	cont=0
	while [ $cont == 0 ]
	do
		echo 'Do you want to change the minute cron sends mails?'
		echo "1 Yes"
		echo "2 Set to every minute"
		echo "3 No"
		read selection
		if [ $selection == 1 ]
		then
			cont=1
			while [ $continue == 0 ]
			do
				echo 'Please input the minute (0-59) to repeat the task'
				read min
				if [ $min -gt -1 -a $min -lt 60 ]
				then
					continue=1
				fi
		done
		elif [ $selection == 2 ]
		then
			cont=1
			min=*
		elif [ $selection == 3 ]
		then
			cont=1
		fi
	done
	continue=0
	selection=0
	cont=0
	while [ $cont == 0 ]
	do
		echo 'Do you want to change the hour cron sends mails?'
		echo "1 Yes"
		echo "2 Set to every hour"
		echo "3 No"
		read selection
		if [ $selection == 1 ]
		then
			cont=1
			while [ $continue == 0 ]
			do
				echo 'Please input the hour (0-23) to repeat the task'
				read hour
				if [ $hour -gt -1 -a $hour -lt 24 ]
				then
					continue=1
				fi
		done
		elif [ $selection == 2 ]
		then
			cont=1
			hour=*
		elif [ $selection == 3 ]
		then
			cont=1
		fi
	done
	continue=0
	selection=0
	cont=0
	while [ $cont == 0 ]
	do
		echo 'Do you want to change the day of the month cron sends mails?'
		echo "1 Yes"
		echo "2 Set to every day of the month"
		echo "3 No"
		read selection
		if [ $selection == 1 ]
		then
			cont=1
			while [ $continue == 0 ]
			do
				echo 'Please input the day of the month (1-31) to repeat the task'
				read daym
				if [ $daym -gt 0 -a $daym -lt 32 ]
				then
					continue=1
				fi
		done
		elif [ $selection == 2 ]
		then
			cont=1
			daym=*
		elif [ $selection == 3 ]
		then
			cont=1
		fi
	done
	continue=0
	selection=0
	cont=0
	while [ $cont == 0 ]
	do
		echo 'Do you want to change the month cron sends mails?'
		echo "1 Yes"
		echo "2 Set to every month"
		echo "3 No"
		read selection
		if [ $selection == 1 ]
		then
			cont=1
			while [ $continue == 0 ]
			do
				echo 'Please input the month (1-12) to repeat the task'
				read month
				if [ $month -gt 0 -a $month -lt 13 ]
				then
					continue=1
				fi
		done
		elif [ $selection == 2 ]
		then
			cont=1
			
			month=*
		elif [ $selection == 3 ]
		then
			cont=1
		fi
	done
	continue=0
	selection=0
	cont=0
	while [ $cont == 0 ]
	do
		echo 'Do you want to change the day of the week cron sends mails?'
		echo "1 Yes"
		echo "2 Set to every day of the week"
		echo "3 No"
		read selection
		if [ $selection == 1 ]
		then
			cont=1
			while [ $continue == 0 ]
			do
				echo 'Please input the day of the week (0-6) to repeat the task, 6 is Sunday'
				read dayw
				if [ $dayw -gt -1 -a $dayw -lt 7 ]
				then
					continue=1
				fi
		done
		elif [ $selection == 2 ]
		then
			cont=1
			dayw=*
		elif [ $selection == 3 ]
		then
			cont=1
		fi
	done
	echo $min $hour $daym $month $dayw
elif [ $option == 4 ]
then
	echo 'This are the current settings'
	echo "Minute:" $min
	echo "Hour:" $hour
	echo "Day of the Month:" $daym
	echo "Month:" $month
	echo "Day of the Week:" $dayw
elif [ $option == 5 ]
then
	echo 'Ending the service'
else
	echo 'invalid command'
fi
done
