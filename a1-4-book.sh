#!/bin/bash
DB_FILE="book_db.txt"
create_db(){
  if [[ -s "$DB_FILE" ]]; then
	echo "DB already exists"
  else
	echo "" >> "$DB_FILE"
	echo "DB Created."
  fi
}

delete_db(){
  if [[ -s "$DB_FILE" ]]; then
	rm "$DB_FILE"
	echo "DB Deleted"
  else
	echo "No DB found to Delete"
  fi
}

add_book() {
  echo "Enter Book Number:"
  read bookid
  echo "Enter Book Name:"
  read bookname
  echo "Enter Author"
  read author
  echo "Enter Publisher"
  read pub
  echo "Enter Price"
  read price
  echo "$bookid,$bookname,$author,$pub,$price" >> "$DB_FILE"
  echo "Book added successfully!"
}
view_books() {
  if [[ -s "$DB_FILE" ]]; then
	echo "Book No | Name    	| Author | Publisher | Price"
	echo "------------------------------"
	column -t -s',' "$DB_FILE"
  else
	echo "No book records found."
  fi
}

search_book() {
  echo "Enter Book Number to search:"
  read bookid
  grep "^$bookid," "$DB_FILE" > /dev/null
  if [[ $? -eq 0 ]]; then
	echo "Record Found:"
	grep "^$bookid," "$DB_FILE" | column -t -s','
  else
	echo "Book with Book No $bookid not found."
  fi
}

delete_book() {
  echo "Enter Book Number to delete:"
  read bookid
  bookid=$(echo "$bookid" | tr -d '[:space:]')

  if grep -q "^$bookid," "$DB_FILE"; then
	grep -v "^$bookid," "$DB_FILE" > temp.txt
	mv temp.txt "$DB_FILE"
	echo "Book record deleted."
  else
	echo "Book with Book No $bookid not found."
  fi
}

update_book() {
  echo "Enter Book Number to update:"
  read bookid

  if grep -q "^$bookid," "$DB_FILE"; then
	echo "Enter new Name of Book:"
	read name
	echo "Enter new Author:"
	read author
	echo "Enter new Publisher:"
	read pub
	echo "Enter new Price:"
	read price
	new_record="$bookid,$name,$author,$pub,$price"
	grep -v "^$bookid," "$DB_FILE" > temp.txt
	echo "$new_record" >> temp.txt
	mv temp.txt "$DB_FILE"
	echo "Book record updated."
  else
	echo "Book with Book No $bookid not found."
  fi
}
while true; do
  echo ""
  echo "====== Book Database Menu ======"
  echo "0. Create DB"
  echo "1. Add"
  echo "2. View"
  echo "3. Search"
  echo "4. Delete"
  echo "5. Update"
  echo "6. Delete DB"
  echo "7. Exit"
  echo "Choose an option:"
  read choice
  case $choice in
	0) create_db ;;
	1) add_book ;;
	2) view_books ;;
	3) search_book ;;
	4) delete_book ;;
	5) update_book ;;
	6) delete_db ;;
	7) echo "Exiting..."; break ;;
	*) echo "Invalid option, try again." ;;
  esac
done
