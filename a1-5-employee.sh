#!/bin/bash

DB_FILE="employee_db.txt"

# Function to create a new database
create_database() {
    > "$DB_FILE"
    echo "Employee database created successfully."
}

# Function to view the database
view_database() {
    if [ ! -s "$DB_FILE" ]; then
        echo "Database is empty."
    else
        echo "Employee Records:"
        column -t -s "," "$DB_FILE"
    fi
}

# Function to insert a new record
insert_record() {
    echo "Enter Employee ID:"
    read id
    echo "Enter Name:"
    read name
    echo "Enter Age:"
    read age
    echo "Enter Department:"
    read dept
    echo "Enter Basic Salary:"
    read basic
    echo "Enter HRA:"
    read hra
    echo "Enter DA:"
    read da
    echo "Enter Deductions:"
    read deductions

    echo "$id,$name,$age,$dept,$basic,$hra,$da,$deductions" >> "$DB_FILE"
    echo "Record inserted successfully."
}

# Function to delete a record
delete_record() {
    echo "Enter Employee ID to delete:"
    read del_id
    if grep -q "^$del_id," "$DB_FILE"; then
        grep -v "^$del_id," "$DB_FILE" > temp.txt && mv temp.txt "$DB_FILE"
        echo "Record deleted."
    else
        echo "Record not found."
    fi
}

# Function to modify a record
modify_record() {
    echo "Enter Employee ID to modify:"
    read mod_id
    if grep -q "^$mod_id," "$DB_FILE"; then
        grep -v "^$mod_id," "$DB_FILE" > temp.txt
        mv temp.txt "$DB_FILE"
        echo "Enter new details:"
        insert_record
        echo "Record modified."
    else
        echo "Record not found."
    fi
}

# Function to calculate salary
calculate_salary() {
    echo "Enter Employee ID to calculate salary:"
    read sal_id
    record=$(grep "^$sal_id," "$DB_FILE")
    if [ -z "$record" ]; then
        echo "Employee not found."
    else
        IFS=',' read -r id name age dept basic hra da deductions <<< "$record"
        salary=$((basic + hra + da - deductions))
        echo "Total Salary for $name (ID: $id) is: ₹$salary"
    fi
}

# Menu loop
while true; do
    echo ""
    echo "========= Employee Database Menu ========="
    echo "a) Create Database"
    echo "b) View Database"
    echo "c) Insert a Record"
    echo "d) Delete a Record"
    echo "e) Modify a Record"
    echo "f) Calculate Salary"
    echo "g) Exit"
    echo "Enter your choice:"
    read choice

    case $choice in
        a) create_database ;;
        b) view_database ;;
        c) insert_record ;;
        d) delete_record ;;
        e) modify_record ;;
        f) calculate_salary ;;
        g) echo "Exiting..."; break ;;
        *) echo "Invalid option. Please choose a-g." ;;
    esac
done
