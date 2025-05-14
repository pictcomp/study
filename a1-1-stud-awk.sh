DB_FILE="stud.text"

create_database() {
    if [ ! -f "$DB_FILE" ]; then
        touch "$DB_FILE"
        echo "ID,Name" > "$DB_FILE"
        echo "Student database created successfully!"
    else
        echo "Database already exists."
    fi
}

view_database () {
    if [ -f "$DB_FILE" ]; then
        cat "$DB_FILE"
    else
        echo "Database not found. Create it first."
    fi
}

insert_record() {
    if [ ! -f "$DB_FILE" ]; then
        echo "Create database first."
        return
    fi
    echo "Enter student ID: "
    read ID
    echo "Enter student name: "
    read name

    echo "$ID,$name" >> "$DB_FILE"
    echo "Record added successfully!"
}

delete_record() {
    if [ ! -f "$DB_FILE" ]; then
        echo "Database does not exist. Please create it first."
        return
    fi
    echo "Enter the student ID to delete: "
    read ID
    grep -v "^$ID," "$DB_FILE" > "$DB_FILE.tmp" && mv "$DB_FILE.tmp" "$DB_FILE"
    echo "Record deleted if it existed."
}

modify_record() {
    if [ ! -f "$DB_FILE" ]; then
        echo "Database does not exist. Please create it first."
        return
    fi
    echo "Enter ID to modify: "
    read ID
    record=$(grep "^$ID," "$DB_FILE")

    if [ -z "$record" ]; then
        echo "Record not found."
        return
    fi

    echo "Enter new name: "
    read name

    awk -F, -v id="$ID" -v name="$name" 'BEGIN {OFS=","}
    {
        if ($1 == id) {
            if (name != "") $2 = name
        }
        print $0
    }' "$DB_FILE" > "$DB_FILE.tmp" && mv "$DB_FILE.tmp" "$DB_FILE"
    echo "Record modified successfully!"
}

display_student() {
    if [ ! -f "$DB_FILE" ]; then
        echo "Database does not exist. Please create it first."
        return
    fi
    echo "Enter student ID to display: "
    read ID
    record=$(grep "^$ID," "$DB_FILE")
    if [ -z "$record" ]; then
        echo "Record not found."
    else
        echo "Student Record: $record"
    fi
}

display_menu() {
    echo
    echo "====== STUDENT DATABASE MANAGEMENT ======"
    echo "1. Create Database"
    echo "2. View Database"
    echo "3. Insert a Record"
    echo "4. Delete a Record"
    echo "5. Modify a Record"
    echo "6. Display Result of a Particular Student"
    echo "7. Exit"
    echo "Please choose an option:"
}

while true; do
    display_menu
    read -p "Enter your choice (1-7): " choice
    case $choice in
        1) create_database ;;
        2) view_database ;;
        3) insert_record ;;
        4) delete_record ;;
        5) modify_record ;;
        6) display_student ;;
        7) echo "Exiting the program."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done