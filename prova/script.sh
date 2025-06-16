#!/bin/bash

grep -v "^#" "data.csv" | sed 's/,//g' > "data.txt"

awk '{
	for (i=1; i<=NF; i++){
		if ( $i % 2 == 0) count++
	} 
} END {
	print count
}' "data.txt" > "even_numbers.txt"

awk '{
	r=sqrt($1^2 + $2^2 + $3^2)
	if (r > 100 * sqrt(3)/2)
		count_gt++
	else 
		count_le++
} END {
	print "Greater than 100 * sqrt(3) / 2:", count_gt
	print "Less or equal:", count_le
}' "data.txt" > "count.txt"

for i in $(seq 1 $1); do
	awk -v d="$i" '{
		for (j=1; j<=NF; j++) {
			$j = $j / d
		}
		print
	} ' "data.txt" > "data_$i.txt"
done
