#!/bin/bash

totalLine ()
{
	echo "$1" | wc -l
}

stringPart ()
{
	f1=$(echo "$1" | head -"$3")
	fa=$(totalLine "$f1")
	declare -i f2=$fa-"$2"+1
	ff=$(echo "$f1" | tail -"$f2")
        echo "$ff"
}

stringSplit ()
{
	tl=$(totalLine "$1")

	for (( j=1; j<=$tl; j++ )); do
		line=$(echo "$1" | head -$j | tail -1)
		echo -n "$line "
	done
	echo ""
}

getLine ()
{
	echo "$1" | head -"$2" | tail -1
}

system_profiler SPAirPortDataType > /tmp/.sp.txt

str="$(cat /tmp/.sp.txt)"
x2=$(( $(echo "$str" | grep -n awdl0 | cut -d ":" -f 1) - 1 ))
x1=$(( $(echo "$str" | grep -n "Other Local Wi-Fi Networks:" | cut -d ":" -f 1) + 1 ))
networks=$(stringPart "$str" "$x1" "$x2")

nets=$(echo "$networks" | grep -n "PHY" | cut -d ":" -f 1)

lin=$(stringSplit "$nets")
net=()
for i in $lin; do net+=($i) ; done

tl=$(totalLine "$nets")
for (( j=0; j<=($tl-1); j++ )); do
	inx=$(( ${net[$j]} - 1 ))
	out=$(getLine "$networks" $inx)
	echo $out
done

rm /tmp/.sp.txt

exit 0



