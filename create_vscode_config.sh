#!/bin/zsh
#
# Please run "chmod +x ~/Script/create_vscode_config.sh"
# This script creates a .vscode folder and a settings.json file in the specified directory.
# 1. Validates that the target directory exists.
# 2. Creates the .vscode directory if it doesn't exist.
# 3. Creates a settings.json file with default content inside the .vscode directory, if it doesn't already exist.
#
# To make this script easily accessible via a simple command, you can add a function in your .zshrc file.
#
# Example for function (allows passing parameters):
# createvscode() {
#     # Input Validation
#     if [ $# -lt 1 ]; then
#         echo "Usage: $0 <target_directory>"
#         return 1
#     fi
#     ~/Script/create_vscode_config.sh "$1"
# }
#
# After editing your .zshrc file, run 'source ~/.zshrc' to apply the changes.
#
# Usage:
# createvscode /path/to/your/project
# The first argument is the path to the target directory where the .vscode folder will be created.

# Input Validation
if [ $# -lt 1 ]; then
	echo "Usage: $0 <target_directory>"
	exit 1
fi

# Variable Assignment
target_dir=$1
vscode_dir="$target_dir/.vscode"
settings_file="$vscode_dir/settings.json"
settings_content='{
  // 字體和界面顯示相關設定
  "editor.fontSize": 12,
  "editor.fontFamily": "Monaco",
  "editor.wordWrap": "on",

  // 代碼編寫和格式化相關設定
  "editor.formatOnSave": false,
  "files.trimTrailingWhitespace": true,
  "editor.parameterHints.enabled": true,

  // 文件保存和自動保存相關設定
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000,

  // 文件和編輯器行為相關設定
  "files.encoding": "utf8",
  "editor.renderLineHighlight": "all",

  // 版本控制相關設定
  "git.autofetch": true,

  // 進階代碼輔助設定
  "path-intellisense.extensionOnImport": true,
  "editor.tabCompletion": "on",
  "javascript.suggest.autoImports": true,
  "typescript.suggest.autoImports": true,

  // 語法檢查設定
  "javascript.validate.enable": true,
  "typescript.validate.enable": true,
  "css.validate": true,
  "html.validate.scripts": true,
  "html.validate.styles": true,
  "json.validate.enable": true,

  // 額外的進階代碼輔助設定
  "editor.bracketPairColorization.enabled": true,

  // Python 配置
  "python.analysis.autoImportCompletions": true,
  "python.terminal.activateEnvironment": true,

  // 指定額外的 Python 模組搜索路徑
  "python.analysis.extraPaths": ["path"],

  // Python 語言特定設定
  "[python]": {
    "diffEditor.ignoreTrimWhitespace": false,
    "editor.formatOnType": true,
    "editor.wordBasedSuggestions": "off",
    "editor.defaultFormatter": "ms-python.black-formatter",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.organizeImports": "explicit"
    }
  },

  // Python 分析和類型檢查
  "python.analysis.typeCheckingMode": "basic",
  "python.analysis.completeFunctionParens": true,

  // isort 配置
  "isort.args": ["--profile", "black"],

  // Prettier 設定
  "[html]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[css]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[jsonc]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },

  // Live Server 設定
  "liveServer.settings.AdvanceCustomBrowserCmdLine": "chrome",
  "liveServer.settings.port": 5500,
  "liveServer.settings.NoBrowser": false,
  "liveServer.settings.fullReload": true
}'

# Error Handling: Check if the target directory exists
if [ ! -d "$target_dir" ]; then
	echo "Error: Target directory $target_dir does not exist."
	exit 1
fi

# Function to prompt the user for confirmation
prompt_user() {
	local prompt_message=$1
	local response

	echo "$prompt_message"
	read "proceed?Proceed ([y]/n)?"
	if [[ "$proceed" == "n" || "$proceed" == "N" ]]; then
		return 1
	fi
	return 0
}

# Core Logic: Create the .vscode directory
create_vscode_config() {

	# Create the .vscode directory if it doesn't exist
	mkdir -p "$vscode_dir"

	if [ -f "$settings_file" ]; then

		# Optional: Prompt the user to confirm overwriting the existing settings.json file
		if ! prompt_user "$settings_file already exists. Do you want to overwrite it?"; then
			exit 1
		fi
		echo "$settings_content" >"$settings_file"

	else
		echo "$settings_content" >"$settings_file"
	fi
}

# Optional: Case-Sensitive Directory Check
if ! prompt_user "Please check if a directory with a similar name (but different case) already exists."; then
	exit 1
fi

# Call the function
create_vscode_config

# Completion Message
echo "$settings_file setup is complete for $(date +"%Y-%m-%d %H:%M:%S")"

# Exit Status
exit 0
