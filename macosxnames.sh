#!/usr/bin/env zsh -f
# Purpose: Show the names and version numbers of all the versions of Mac OS X or MacOS in the “X” era
#
# From:	Timothy J. Luoma
# Mail:	luomat at gmail dot com
# Date:	2018-08-21

NAME="$0:t"

if [[ -e "$HOME/.path" ]]
then
	source "$HOME/.path"
else
	PATH='/usr/local/scripts:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin'
fi

function show_usage {

echo "<$NAME> is a simple script designed to help you easily remember (or search for) information about the “code names” and version numbers of Mac OS X / OS X / macOS.

Examples:
	* If you can’t remember what version “10.8” was called, use <$NAME 10.8> (or just <$NAME 8>)

	* If you can’t remember which version was called “Yosemite”, use <$NAME Yosemite>

	* If you want to know which versions was called “Sierra”, use <$NAME sierra>

	* If you want to know which versions had “Sierra” in the name, use <$NAME ' sierra'> (note the single quotes and the space)
		(The same goes for ' leopard' and ' lion' if you want those.)

If you do not supply any input, a full list will be shown.
Oh, and finally, note that all searches are cASe INSenSitiVe.
"
}

INPUT="$@"

IFS=$'\n' INFO=($(echo "
 10.15	macOS Catalina
 10.14	macOS Mojave
 10.13	macOS High Sierra
 10.12	macOS Sierra
 10.11	OS X El Capitan
 10.10	OS X Yosemite
 10.9	OS X Mavericks
 10.8	OS X Mountain Lion
 10.7	Mac OS X Lion
 10.6	Mac OS X Snow Leopard
 10.5	Mac OS X Leopard
 10.4	Mac OS X Tiger
 10.3	Mac OS X Panther
 10.2	Mac OS X Jaguar
 10.1	Mac OS X Puma
 10.0	Mac OS X Cheetah
"))

if [ "$#" = "0" ]
then
	echo "$INFO"

	THIS_MAC=$(sw_vers -productVersion)

	echo "	(Try “$NAME --help” for tips/hints.)"
	echo "	(This Mac is running: $THIS_MAC)"

else
	case "$INPUT:l" in
		-h|--help|help)
			show_usage
		;;

		all|--all)
			echo "$INFO"
		;;

		10.[0-9])
			echo "$INFO" | egrep "^ $INPUT	" || echo "$INFO" | fgrep "$INPUT"
		;;

		[0-9]*)
			echo "$INFO" | egrep "^ 10.$INPUT	" || echo "$INFO" | fgrep "$INPUT"
		;;

		leopard)
			echo "$INFO" | fgrep -i "$INPUT" | fgrep -v Snow
		;;

		lion)
			echo "$INFO" | fgrep -i "$INPUT" | fgrep -v Mountain
		;;

		sierra)
			echo "$INFO" | fgrep -i "$INPUT" | fgrep -v High
		;;

		*)
			echo "$INFO" | fgrep -i -- "$INPUT"
		;;
	esac
fi

exit 0
#EOF
