sum=0

for num in {1000..2000}
do
    if [[ $num =~ ^[01]+$ ]]; then
        sum=$((sum + num))
    fi
done

echo "The sum of numbers between 1000 and 2000 that consist only of digits 0 and 1 is: $sum"
