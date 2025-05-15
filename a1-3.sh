#!/bin/bash

# Function to find biggest of three numbers
biggest_of_three() {
  read -p "Enter first number: " a
  read -p "Enter second number: " b
  read -p "Enter third number: " c

  if [ "$a" -ge "$b" ] && [ "$a" -ge "$c" ]; then
    echo "$a is the biggest"
  elif [ "$b" -ge "$a" ] && [ "$b" -ge "$c" ]; then
    echo "$b is the biggest"
  else
    echo "$c is the biggest"
  fi
}

# Function to reverse a number
reverse_number() {
  read -p "Enter a number to reverse: " num
  rev=0
  while [ "$num" -gt 0 ]; do
    rem=$((num % 10))
    rev=$((rev * 10 + rem))
    num=$((num / 10))
  done
  echo "Reversed number: $rev"
}

# Function to print word N times
print_word_n_times() {
  read -p "Enter number of times to print: " N
  read -p "Enter word: " word

  for ((i = 1; i <= N; i++)); do
    echo "$word"
  done
}

# Function to sum digits of a 4-digit number
sum_digits() {
  read -p "Enter a 4-digit number: " num

  if [ ${#num} -ne 4 ] || ! [[ "$num" =~ ^[0-9]+$ ]]; then
    echo "Please enter a valid 4-digit number"
    return
  fi

  sum=0
  for ((i = 0; i < ${#num}; i++)); do
    digit=${num:$i:1}
    sum=$((sum + digit))
  done
  echo "Sum of digits: $sum"
}

# Main Menu
echo "Select an option:"
echo "a) Find biggest of three numbers"
echo "b) Reverse a number"
echo "c) Print word N times"
echo "d) Sum of digits of 4-digit number"
read -p "Enter choice (a/b/c/d): " choice

case "$choice" in
  a)
    biggest_of_three
    ;;
  b)
    reverse_number
    ;;
  c)
    print_word_n_times
    ;;
  d)
    sum_digits
    ;;
  *)
    echo "Invalid option. Please select a, b, c, or d."
    ;;
esac
