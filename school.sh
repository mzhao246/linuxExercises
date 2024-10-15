#!/bin/bash
grep "MADISON SCHOOLS" Property_Tax_Roll.csv | cut -d, -f7 | {
    sum=0
    count=0
    while read value; do
        sum=$((sum + value))
        count=$((count + 1))
    done
    echo "Total Assessed Value: $sum"
    echo "Average Assessed Value: $((sum / count))"
}
