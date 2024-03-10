# Prodir

The `prodir` command simplifies navigation to frequently used directories. It supports setting a target directory with the `-set` flag, unsetting with the `-reset` flag, displaying the current directory with the `-dir` flag, and showing usage information with `-help` or `--h`. The target directory persists across system reboots.

## Setup

### Define a Shell Function

1. Open your shell's initialization file. Use `nano ~/.bashrc` for Bash or `nano ~/.zshrc` for Zsh.
2. Add the following function at the end:

    ```bash
    prodir() {
        if [[ "$1" == "-set" ]]; then
            ~/prodir/prodir.sh -set "$2"
        elif [[ "$1" == "-reset" ]] || [[ "$1" == "-dir" ]] || [[ "$1" == "-help" ]] || [[ "$1" == "--h" ]]; then
            # Directly pass these arguments to the script
            ~/prodir/prodir.sh "$@"
        else
            # Default action: navigate to the directory or show an error
            local dir=$(~/prodir/prodir.sh "$@")
            if [[ -d "$dir" ]]; then
                cd "$dir" || return
            fi
        fi
    }
    ```

3. Save and exit the editor.
4. Apply the changes by sourcing your shell's configuration file: `source ~/.bashrc` for Bash or `source ~/.zshrc` for Zsh.

## Usage

- **Set a Project Directory**: `prodir -set /path/to/directory`
- **Navigate to Project Directory**: `prodir`
- **Unset Project Directory**: `prodir -reset`
- **Display the Current Directory**: `prodir -dir`
- **Display Help**: `prodir -help` or `prodir --h`

## How It Works

- **Setting a Directory**: Saves the specified directory path to a file when the `-set` flag is used.
- **Navigating**: Reads the saved directory path from the file and changes to it when called without arguments.
- **Unsetting**: Removes the saved directory path from the file when the `-reset` flag is used.
- **Displaying**: Echoes the saved directory path without changing to it when the `-dir` flag is used.
- **Help**: Displays usage information when the `-help` or `--h` flag is used.
- The directory path is stored in a file, ensuring persistence across sessions and reboots.

## Troubleshooting

- **Command Not Found**: Verify the `prodir` function is correctly defined in your shell's configuration file and that you have sourced the file after adding the function.
- **Directory Not Changing**: Due to shell limitations, changing the directory must be done through a shell function, not directly from a script. Ensure the function is correctly implemented in your shell configuration file.

## License

The `prodir` command is open-source and can be freely modified and distributed. No attribution is required, but it is always appreciated.
