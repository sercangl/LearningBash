#!/bin/bash




applicationTittle="project"




dialog  $applicationTittle --title "Entring Profile" --menu "Options" 50 50 3 1 "Existing Profile" 2 "New Profile" 3 "Exit" 2> $SumUp
menuu=$(cat $SumUp)
 

 
 Name=""
Pass=""
Check=0
SumUp=$(mktemp /tmp/SumUp.XXXXXX)


 
 case $menuu in
	1) prep;;
	2) create;;
	3) exit;;	
esac



if [[ $Check == 1 ]]
then
	dialog  $applicationTittle --title "Menu" --menu "Chooseee  " 50 50 3 1 "Write for daily" 2 "Write, read or Edit a Daily  " 3 "Exit" 2> $SumUp
	menuu=$(cat $SumUp)

case $menuu in
        1) write;;
        2) rewrday;;
		3) exit;;
esac
	exit
fi 




function rewrday(){
	
	dialog  $applicationTittle --title "Inform" --msgbox "Enter a date.." 50 50

	while true
	do
	
	
	
	dialog  $applicationTittle --title "Reading..." --inputbox "Enter day.." 50 50 2> $SumUp
	ReadDay=$(cat $SumUp)
	if ! [[ $ReadDay =~ ^[0-9]+$  ]]
	then
		dialog $applicationTittle --title "Anything Wrong"  --yesno "Try again" 50 50 2> $SumUp
		if [[ $? == 1  ]]
		then exit
		else continue
		fi
	elif (( $ReadDay < 1 || $ReadDay > 31 ))
	then
		dialog  $applicationTittle --title "Anything Wrong"  --yesno "Try again" 50 50 2> $SumUp
		if [[ $? == 1  ]]
		then exit
		else continue
		fi 
	fi
	
	
	
	
	
	
	
	
	
	
	dialog  $applicationTittle --title "Reading.." --inputbox "Enter month" 50 50 2> $SumUp
	ReadMonth=$(cat $SumUp)
	if ! [[ $ReadMonth =~ ^[0-9]+$ ]]
	then
		dialog  $applicationTittle --title "Anything Wrong"  --yesno "Try again?" 50 50 2> $SumUp
		if [[ $? == 1  ]]
	        then exit
		else continue
		fi													
	elif (( $ReadMonth < 1 || $ReadMonth > 12 ))
	then
	       dialog  $applicationTittle --title "Anything Wrong"  --yesno "Try again?" 50 50 2> $SumUp
	       if [[ $? == 1  ]]
	       then exit
	       else continue
	       fi
	elif (( $ReadDay == 30 && $ReadMonth == 2 ))
	then
		dialog  $applicationTittle --title "Anything Wrong"  --yesno "Try again?" 50 50 2> $SumUp
		if [[ $? == 1  ]]
		then exit
		else continue
		fi
	elif (( $ReadDay == 31 ))
	then 
		if (( $ReadMonth == 2 ||$ReadMonth == 4 || $ReadMonth == 6 || $ReadMonth == 9 || $ReadMonth == 11 ))
		then
			dialog  $applicationTittle --title "Anything Wrong"  --yesno "Try again?" 50 50 2> $SumUp
			if [[ $? == 1  ]]
			then exit
			else continue
			fi
		fi								
	fi

     






	 dialog  $applicationTittle --title "Reading a year" --inputbox "Enter year" 50 50 2> $SumUp
	ReadYear=$(cat $SumUp)
	if ! [[ $ReadYear =~ ^[0-9]+$  ]]
	then
		dialog  $applicationTittle --title "Anything Wrong"  --yesno "Try again?" 50 50 2> $SumUp
	        if [[ $? == 1  ]]
		then exit
		else continue
		fi
	elif (( $ReadYear < 1900 || $ReadYear > 2018 ))
	then
	        dialog  $applicationTittle --title "Anything Wrong"  --yesno "Try again?" 50 50 2> $SumUp
	        if [[ $? == 1  ]]
	        then exit
	        else continue
	        fi 
        fi
	break
        done
	
	if ls "$ReadDay-$ReadMonth-$ReadYear-project.txt" >&1;
	then
		dialog  $applicationTittle --title "Information" --msgbox "Entry exists. " 50 50
		
		file="$ReadDay-$ReadMonth-$ReadYear-project.txt"
		cat $file > $SumUp
		dialog  $applicationTittle --title "$ReadDay/$ReadMonth/$ReadYear" --editbox $SumUp 50 50 2> $file
		dialog  $applicationTittle --title "$ReadDay/$ReadMonth/$ReadYear" --msgbox "Saved on $file" 50 50
	else
		dialog  $applicationTittle --title "Information" --msgbox "Entery doesn't exist. Creating one." 50 50
		file="$ReadDay-$ReadMonth-$ReadYear-project.txt"
		> $file
		dialog  $applicationTittle --title "$ReadDay/$ReadMonth/$ReadYear" --editbox $file 80 80   2> $file
		dialog  $applicationTittle --title "$ReadDay/$ReadMonth/$ReadYear" --msgbox "Saved on $file" 50 50
	fi
}





function write(){
	day=`date +%d`
	month=`date +%b`
	year=`date +%Y`
       
	entryFile="$day-$month-$year-project.txt"
	> $MyFile
	dialog  $applicationTittle --title "$day/$month/$year" --editbox $MyFile 80 80   2> $MyFile
	dialog  $applicationTittle --title "$day/$month/$year" --msgbox "Saved on $MyFile" 50 50
	
}






                        






function create(){
	while true
	do
		dialog  $applicationTittle --title "Create Profile" --inputbox "Your Name" 50 50 2> $SumUp
		Name=$(cat $SumUp)
		if ! [[ $Name =~ ^[a-zA-Z]+$ ]]
		then
			dialog  $applicationTittle --title "Anything Wrong"  --yesno "Please only use letters a-z without spaces or special characters, try again?" 50 50 2> $SumUp
			if [[ $? == 1  ]]
			then exit 
			fi
		else
			break	
		fi
	done

	while true
	do
		dialog  $applicationTittle --title "Create Profile" --passwordbox "Your Password" 50 50 2> $SumUp
		if ! [[ $Name =~ ^$ ]]
		then break
		fi
	done
	Pass=$(cat $SumUp)
	zip -P $Pass $Name.zip $SumUp
       	zip -d $Name.zip $SumUp	
	Check=1
}









function prep(){
	while true  
	do
		dialog  $applicationTittle --title "Access Profile" --inputbox "Your Name (case sensitive)" 50 50 2> $SumUp
		nameEntry=$(cat $SumUp)
		if [[ -e $nameEntry.zip ]]
		then 
			Name=$nameEntry
			break
		fi
	done

	while true
	do
		dialog  $applicationTittle --title "Access Profile" --passwordbox "Your Password" 50 50 2> $SumUp
		Pass=$(cat $SumUp)
		unzip -uP $Pass $Name.zip
		file=("./*project.txt")	
		if ls ./*-project.txt >&1; 
		then 
			break
		else    
   			dialog  $applicationTittle --title "Anything Wrong"  --yesno "Something is wrong with password, try again?" 50 50 2> $SumUp
			if [[ $? == 1  ]]
			then exit
			fi											
		fi
	done
	Check=1
}















function exit(){
	if [[ $Check == 1 ]]
	then
	zip -P $Pass $Name.zip *-project.txt 
	fi
	exit 0
}

