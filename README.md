# Prodir

Command `prodir`, handles a -set flag to save a directory path, and changes the current directory to the saved path when called without arguments. The saved path persists across system reboots.

## Setup

Define a Shell Function

Open your shell's initialization file: nano ~/.bashrc (or the equivalent for your shell: ~/.zshrc for zsh).
Add the following function at the end:

```bash
prodir() {
    if [ "$1" == "-set" ]; then
        ~/prodir/prodir.sh -set "$2"
    else
        local dir=$(~/prodir/prodir.sh)
        if [ -d "$dir" ]; then
            cd "$dir" || return
        fi
    fi
}
```

Save and exit the editor.
Apply the changes: source ~/.bashrc (or equivalent for your shell).

## How It Works

    When you run prodir -set <directory>, the function calls the script with the -set flag, which saves the provided directory path to a file.
    Running prodir without arguments reads the saved directory path from the file and attempts to cd into it.
    The directory path is stored in a file, so it persists across sessions and reboots.

## Troubleshooting

    Command Not Found: Ensure the prodir function is correctly defined in your shell's configuration file and that you have sourced the file after adding the function.
    Directory Not Changing: Remember that due to shell limitations, changing the directory must be done through a shell function, not directly from a script. Ensure the function is correctly implemented in your shell configuration file.

## License

The prodir command is open-source and can be freely modified and distributed. No attribution is required, but it is always appreciated.