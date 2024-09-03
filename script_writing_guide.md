# Script Writing Guide

This document provides a structured guide on how to write clear and effective shell scripts. The focus is on ensuring readability, maintainability, and ease of use.

## Script Structure

A well-structured script consists of several key components: the shebang, a detailed header, function definitions, and the main execution flow.

### 1. Shebang

The script should start with a shebang to specify the interpreter. For Zsh scripts, use:

```zsh
#!/bin/zsh
```

### 2. Header

The header of the script should include detailed comments explaining the purpose of the script, how to use it, and any setup required. The explanation of the script’s purpose should list the specific steps the script will perform.

```zsh
# Please run "chmod +x ~/Script/your_script.sh"
# This script performs specific tasks to [brief description of the script’s purpose].
#
# To make this script easily accessible via a simple command, you can add an alias or function in your .zshrc file.
#
# Add the following to your .zshrc file:
# alias youralias='~/Script/your_script.sh'
#
# Add the following to your .zshrc file:
# youralias() {
#     # Input Validation
#     if [ $# -lt 2 ]; then
#         echo "Usage: $0 <arg1> [<arg2>]"
#         return 1
#     fi
#     ~/Script/your_script.sh "$1" "$2"
# }
#
# After editing your .zshrc file, run 'source ~/.zshrc' to apply the changes.
#
# Usage: youralias /path/to/your/argument another_argument
```

### 3. Body

The body of the script contains the main logic and operations performed by the script. It typically includes:

- Input Validation

```zsh
# Input Validation
if [ $# -lt 1 ]; then
    echo "Usage: $0 <arg1> [<arg2>]"
    exit 1
fi
```

- Variable Assignment

```zsh
# Variable Assignment
arg1=$1
arg2=${2:-default_value}  # Default to 'default_value' if not provided
```

- Error Handling

```zsh
# Error Handling: Example of error handling
if [ ! -d "$arg1" ]; then
    echo "Error: Directory $arg1 does not exist."
    exit 1
fi
```

- Optional

```zsh
# Function to prompt the user for confirmation
prompt_user() {
	local prompt_message=$1

	echo "$prompt_message"
	read "proceed?Proceed ([y]/n)?"
	if [[ "$proceed" == "y" || "$proceed" == "Y" ]]; then
		return 0
	fi
	return 1
}

# Optional: Case-Sensitive Directory Check
if prompt_user "Please check if a directory with a similar name (but different case) already exists."; then
	exit 1
fi
```

- Core Logic

```zsh
# Core Logic: Perform a specific task
perform_task() {
    local param1=$1
    local param2=$2

    # Add your logic here
    echo "Performing task with $param1 and $param2"
}

# Call the function
perform_task "$arg1" "$arg2"
```

### 4. Footer

The footer of the script is used for wrapping up the script’s execution. This typically includes logging the completion of the script and any final messages to the user.

- Completion Message

```zsh
# Completion Message
echo "The script is complete for $(date +"%Y-%m-%d %H:%M:%S")"
```

- Exit Status

```zsh
# Exit Status
exit 0
```
