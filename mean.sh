#!/bin/bash
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "usage: $0 <column> [file.csv]" 1>&2
    exit 0
fi

column=$1
file=${2:-/dev/stdin}

if ! [[ "$column" =~ ^[0-9]+$ ]]; then
    echo "Error: Column number must be a valid integer" 1>&2
    exit 0
fi

cut -d',' -f"$column" "$file" | tail -n +2 | {
    sum=0
    count=0

    while read -r value; do
        if [[ "$value" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
            sum=$(echo "$sum + $value" | bc)
            count=$((count + 1))
        fi
    done

    if [ "$count" -gt 0 ]; then
        mean=$(echo "scale=5; $sum / $count" | bc -l)
        echo "Mean: $mean"
    else
        echo "Error: No valid data" 1>&2
        exit 0
    fi
}
