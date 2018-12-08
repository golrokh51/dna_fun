#!/bin/bash
dots=(6 5 4 4 5 6 7 8 6 5 4 4)
dash=(0 1 3 4 4 3 1 0 3 4 4 3)
nt=("A" "C" "G" "T")
file="tmp.tmp"
grep -e "^[^>]" "$1" > $file
x=0
cnt=0
max=11
lineSize=18

Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[1;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
Gray='\033[2;30m'

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;31m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
IGray='\033[1;30m'

printN() {
	for ((j=1; j<=$1; j++)); do echo -n -e $3$2; done
}

while IFS= read line
do
        # display $line or do somthing with $line
	color=$IBlack
	for (( i=0; i<${#line}; i++ )); do
  		car="${line:$i:1}"
  		
  		
  		if [ "$car" == "T" ]; then
  			color=$IBlue
  		elif [ "$car" == "A" ]; then
  			color=$IGreen
  		elif [ "$car" == "C" ]; then
  			color=$IRed
  		elif [ "$car" == "G" ]; then
  			color=$IYellow	
  		fi
  		
  		
  		nbDot=${dots[$cnt]}
  		nbDas=${dash[$cnt]}	
  		printN $nbDot "." $Cyan
  		echo -n " "
  		
  		
  		
  		if ((cnt != 7)); then
  			
  			echo -n -e $IWhite"$"
  			echo -n -e $color$car
  			
  		else
  			echo -n -e $color$car
  			echo -n -e $IWhite"$"
  		fi
  		if ((cnt % 7 == 0)); then
  			nbDot=$(( lineSize - nbDot - 4 ))
  			
  			echo -n " "
  		else
  			nbDot=$(( lineSize - nbDot - nbDas - 6 ))
  			if ((cnt < 7)); then
  				printN $nbDas "-" $Gray
  			else
  				printN $nbDas "-" $IGray
  			fi
  			if [ "$car" == "T" ]; then
  				echo -n -e $IGreen"A"
  			elif [ "$car" == "A" ]; then
  				echo -n -e $IBlue"T"
  			elif [ "$car" == "C" ]; then
  				echo -n -e $IYellow"G"
  			elif [ "$car" == "G" ]; then
  				echo -n -e $IRed"C"	
  			fi
  			echo -n -e $IWhite"$ "
  		fi
  		printN $nbDot "." $Cyan
  		echo  
  		((cnt++))
  		if (("$cnt" > "$max")); then
  			cnt=0
  		fi
	done
	
done <"$file"

rm $file