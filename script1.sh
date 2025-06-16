#!/bin/bash

URL='https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv'
dir_name='students'
file_name='students.csv'
pod_file='pod_students.csv'
physics_file='physics_students.csv'
counts='counts.csv'
most_counts='most_counts.csv'

if [ ! -d "$dir_name" ]; then
    mkdir "$dir_name"
fi

cd $dir_name

if [ ! -f "$file_name" ]; then
    wget -O "$file_name" "$URL"
fi

grep -i "pod" "$file_name" > "$pod_file"
grep -i "physics" "$file_name" > "$physics_file"

> "$counts"
for letter in {A..Z}; do
    count=$(grep -i "^$letter" "$file_name" | wc -l)
    echo "$count, $letter" >> "$counts"
done

sort -nr "$counts" | head -1 > "$most_counts"

awk 'NR > 1 { group = ( NR - 1 ) % 18; print > ("group_" group ".txt") }' "$file_name"
