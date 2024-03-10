#!/bin/bash

# File to store the persisted directory
DIR_STORE=~/.prodir_store

# Function to display help message
display_help() {
    echo "Usage: prodir [OPTION]"
    echo "Navigate to or set the target project directory."
    echo ""
    echo "Options:"
    echo "  -set DIRECTORY   Set the target directory."
    echo "  -reset           Unset the target directory."
    echo "  -dir             Display the currently set target directory."
    echo "  -help, --h       Display this help message."
}

# Function to set the directory
set_directory() {
    echo "$1" > "$DIR_STORE"
    echo "Directory set to $1"
}

# Function to unset the directory
unset_directory() {
    if [ -f "$DIR_STORE" ]; then
        rm "$DIR_STORE"
        echo "Target directory has been unset."
    else
        echo "No target directory is currently set."
    fi
}

# Function to display the directory
display_directory() {
    if [ -f "$DIR_STORE" ]; then
        read -r dir < "$DIR_STORE"
        echo "Current target directory: $dir"
    else
        echo "No target directory is currently set."
    fi
}

# Function to go to the directory
go_to_directory() {
    if [ ! -f "$DIR_STORE" ]; then
        echo "Please set a target directory with -set flag."
        return 1 # Exit with error
    fi

    # Read the directory path from the file
    read -r dir < "$DIR_STORE"
    if [ -d "$dir" ]; then
        # This will not actually change the directory in the user's shell,
        # but we'll handle that aspect separately
        echo "$dir"
    else
        echo "The saved directory does not exist. Please reset."
        return 1 # Exit with error
    fi
}

# Main control flow
if [ "$1" == "-help" ] || [ "$1" == "--h" ]; then
    display_help
elif [ "$1" == "-set" ]; then
    set_directory "$2"
elif [ "$1" == "-reset" ]; then
    unset_directory
elif [ "$1" == "-dir" ]; then
    display_directory
else
    go_to_directory
fi