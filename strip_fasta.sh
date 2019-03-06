#!/bin/sh
#this script will strip gene/protein/etc IDs in a fasta file
#usage: sh strip_fasta.sh [fasta to strip that ends in .fa] [number that corresponds to which ID you want to keep]

#cut up the file name
BEFOREDOT=$(echo $1| cut -d. -f1,1)
AFTERDOT=$(echo $1 | cut -d. -f2,2)

while read LINE; do
    #the variable "CARROTCHECK" will contain the first character of every line
    CARROTCHECK=$(echo $LINE | cut -c1,1)
    #if the variable "CARROTCHECK" is a ">" (aka a gene id)...
    if [ $CARROTCHECK = ">" ]; then
        #the new ID will be the ID at the location you passed to the program
            #assuming the IDs are separated by "|"
        NEWID=$(echo $LINE | cut -d\| -f$2,$2)
        #echo this new ID to the new, stripped file
        echo ">$NEWID" >> ${BEFOREDOT}_stripped.${AFTERDOT}
    #if the first character is anything other than ">" (aka it's a normal sequence line), just echo that line to the new, stripped file
    else
        echo $LINE >> ${BEFOREDOT}_stripped.${AFTERDOT}
    fi
done < $1
