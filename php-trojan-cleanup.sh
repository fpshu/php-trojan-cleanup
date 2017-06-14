#!/bin/bash

####################################################
# php-trojan-cleanup v0.1                          #
# cleanup malicious codes from php files           #
# url: https://github.com/fpshu/php-trojan-cleanup #
# creator: TaPe (tape@fps.hu)                      #
# company: fps web agency                          #
####################################################

# 1st command line argument: option
option=$1

# 2nd command line argument: directory
directory=$2

# number of arguments
args=$#

# detect
function detect
{
	cd $directory
	echo "detect running"
	find . -type f -name '*.php' -print0 | xargs -0 grep --color=auto -inHE '((^<\?php \$wycstink)(.*)(\$plhwwa-1; \?>))'
	echo "detect finished"
}

# cleanup
function cleanup
{
	cd $directory
	echo "cleanup running"
	find . -type f -name '*.php' -print0 | xargs -0 sed -r -i 's/((^<\?php \$wycstink)(.*)(\$plhwwa-1; \?>))//g'
	echo "cleanup finished"
}

# help
function help
{
        echo ""
        echo "php trojan cleanup v0.1"
        echo "   detect <directory>  : detect malicious code in the given directory"
        echo "   cleanup <directory> : remove malicious code in the given directory"
	echo "   help                : this help :)"
        echo ""
	exit 0
}

if [ $args == 2 ]; then
	if [ -d $directory ]; then
		if [ $option = "detect" ]; then
			detect
		else
			if [ $option = "cleanup" ]; then
				cleanup
			else
				help
			fi
		fi
	else
		echo "$directory is not a directory"
	fi
else
	help
fi
