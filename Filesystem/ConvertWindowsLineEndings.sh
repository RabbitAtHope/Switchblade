DIRECTORY="/"

# Loop through all files in the specified directory.
for FILE in "$DIRECTORY"/*; do

  # Check if it's a file.
  if [ -f "$FILE" ]; then
    echo "[$FILE]"
    dos2unix "$FILE"
  fi
done
