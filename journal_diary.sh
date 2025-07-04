
#!/bin/bash

DIARY_DIR="/home/priyanka/My_diary_book"
mkdir -p "$DIARY_DIR"

while true; do

    echo "My Diary"
    echo "=============================="
    echo "Select an option : "
    echo "1) Create New Diary Entry "
    echo "2) View/Edit Today's Diary"
    echo "3) View/Edit Yesterday's Diary"
    echo "4) Exit"
    echo "=============================="
    read -p "Enter your option : " choice

    case $choice in
        1)

            read -p "Enter a title : " USER_INPUT
            TODAY_DATE=$(date '+%Y-%m-%d')
            FILENAME="${TODAY_DATE}_${USER_INPUT}.txt"
            FILEPATH="$DIARY_DIR/$FILENAME"

            echo "Diary Entry - $(date '+%Y-%m-%d %H:%M:%S')" > "$FILEPATH"
            echo "-------------------------------------------" >> "$FILEPATH"
            echo "" >> "$FILEPATH"

            echo "New diary created: $FILENAME"
            nano "$FILEPATH"
            echo "Your diary entry is saved at: $FILEPATH"
            ;;
       2)

            TODAY_DATE=$(date '+%Y-%m-%d')
            FILES=( $DIARY_DIR/${TODAY_DATE}_*.txt )

            if [ ${#FILES[@]} -eq 0 ]; then
                echo "No diary entries found for today: $TODAY_DATE"
            else
                echo "Available diaries for today:"
                select FILE in "${FILES[@]}" "Cancel"; do
                    if [[ "$FILE" == "Cancel" ]]; then
                        break
                    elif [ -n "$FILE" ]; then
                        FILE_NAME=$(basename "$FILE")
                        echo "Opening file: $FILE_NAME"
                        nano "$FILE"
                        echo "You edited the file: $FILE_NAME"
                        break
                    else
                        echo "Invalid selection. Please try again."
                    fi
                done
            fi
            ;;
        3)

            YESTERDAY_DATE=$(date -d "yesterday" '+%Y-%m-%d')
            FILES=( $DIARY_DIR/${YESTERDAY_DATE}_*.txt )

            if [ ${#FILES[@]} -eq 0 ]; then
                echo "No diary entries found for yesterday: $YESTERDAY_DATE"
            else
                echo "Available diaries for yesterday:"
                select FILE in "${FILES[@]}" "Cancel"; do
                    if [[ "$FILE" == "Cancel" ]]; then
                        break
                    elif [ -n "$FILE" ]; then
                        FILE_NAME=$(basename "$FILE")
                        echo "Opening file: $FILE_NAME"
                        nano "$FILE"
                        echo "You edited the file: $FILE_NAME"
                        break
                    else
                        echo "Invalid selection. Please try again."
                    fi
                done
            fi
            ;;
        4)
            echo "Exiting diary....."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select 1, 2, 3, or 4."
            ;;
    esac
    echo ""
done
