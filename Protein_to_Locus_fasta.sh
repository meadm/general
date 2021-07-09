#!/bin/bash
#Takes a downloaded proteome file from NCBI (XYZ.faa) and replaces the protein
#ids and anything else on the gene id line with the locus tag for the protein.
#This is useful because some databases (including FungiDB and AspGD) use NCBI
#locus tags as their gene ids
#Usage: sh Protein_to_Locus_fasta.sh [input protein fasta] [annotation table
#from NCBI] [output protein fasta]
#read each line of the file one by one
while read LINE; do
#establish a variable that is just the first character of each line
    CARROTCHECK=$(echo $LINE | cut -c1)
#if the first character of each line is a carrot (a protein ID) then...
    if [[ $CARROTCHECK == ">" ]]; then
#make a variable that is only the protein id
#removes everything after the first space
        PROTID=$(echo $LINE | cut -d '>' -f2,2 | cut -d ' ' -f1,1)
        LTAG=$(grep $PROTID $2 | cut -f7,7)
        echo ">$LTAG" >> $3
#if the first character of the line isn't a carrot (aka it's a line of sequence)
    else
#just echo the line to the new file
        echo $LINE >> $3
    fi
done < $1
