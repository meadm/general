#!/bin/bash
#1 = name of proteomefile from NCBI
#2 = name of protein table from NCBI
#3 = name of species
while read PROTEOME; do
	CARROT=$(echo $PROTEOME | cut -c1)
	if [ "$CARROT" = ">" ]
	then
		REFSEQ=$(echo $PROTEOME | cut -d '>' -f2,2 | cut -d ' ' -f1,1)
		GENEID=$(grep -w "$REFSEQ" $2 | cut -f7)
		echo ">"$GENEID >> ${3}_proteins.fasta
	else
		echo $PROTEOME >> ${3}_proteins.fasta
	fi
done < $1
