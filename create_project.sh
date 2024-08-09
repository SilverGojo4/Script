#!/bin/zsh
#
# Please run "chmod +x ~/Script/create_project.sh"
# This script creates a project directory with predefined files.
# 1. Create the project directory
# 2. Conditionally create a README.md file based on user input.
#
# To make this script easily accessible via a simple command, you can add a function in your .zshrc file.
#
# Example for function (allows passing parameters):
# createproject() {
#     # Input Validation
#     if [ $# -lt 2 ]; then
#         echo "Usage: $0 <directory> [<create_readme: yes|no>]"
#         return 1
#     fi
#     ~/Script/create_project.sh "$1" "$2"
# }
#
# After editing your .zshrc file, run 'source ~/.zshrc' to apply the changes.
#
# Usage:
# createproject /path/to/your/project yes
# The first argument is the directory where the project will be created.
# The second argument is optional and specifies whether to create a README.md file ('yes' to create, 'no' to skip).
# If the second argument is not provided, the script defaults to creating the README.md file.

# Input Validation
if [ $# -lt 1 ]; then
	echo "Usage: $0 <directory> [<create_readme: yes|no>]"
	exit 1
fi
if [ $# -ge 2 ] && [[ "$2" != "yes" && "$2" != "no" ]]; then
	echo "Error: The second argument must be 'yes' or 'no'."
	exit 1
fi

# Variable Assignment
directory=$1
create_readme=${2:-yes} # Default to 'yes' if not provided
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
gitignore_content='# 忽略 Python 編譯生成的文件
__pycache__/
*.py[cod]
*.pyo
*.pyd
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
*.egg-info/
.installed.cfg
*.egg

# 忽略 pytest 生成的緩存目錄
.pytest_cache/

# 忽略 Java 編譯生成的文件
*.class
# 包含類文件的目錄
bin/
# 包管理器生成的目錄 (如 Maven)
target/

# 通用忽略規則 (日誌文件, 編輯器配置等)
*.log
*.tmp
*.temp
*.swp
*~
*.DS_Store

# 忽略 VSCode 個人化設置
.vscode/'
readme_content="# $directory

A detailed introduction of $directory.

## Project Structure

The toolkit is organized as follows:

### folder_name/

- \`file_name\`: A simple introduction of file.

## Future Plans

- \`file_name\`: A simple introduction of file.

## Installation Requirements

To run the scripts, you'll need the following libraries installed:

- library_name"

# Error Handling: Check if the project directory exists
if [ ! -d "$directory" ]; then
	mkdir -p "$directory"
	echo "Created project directory: $directory"
else
	echo "Error: Directory $directory already exists."
	echo "Please check if a directory with a similar name (but different case) already exists."
	exit 1
fi

# Core Logic: Create the project directory and necessary files
create_project_directory() {

	# Create the project directory structure
	mkdir -p "$directory/.vscode"
	mkdir -p "$directory/src"
	mkdir -p "$directory/logs"
	mkdir -p "$directory/config"
	mkdir -p "$directory/data"
	mkdir -p "$directory/results/models"
	mkdir -p "$directory/results/figures"

	# Create .vscode/settings.json
	echo "$settings_content" >"$directory/.vscode/settings.json"
	echo "Created .vscode/settings.json"

	# Create .gitignore
	echo "$gitignore_content" >"$directory/.gitignore"
	echo "Created .gitignore"

	# Conditionally create README.md
	if [ "$create_readme" = "yes" ]; then
		echo "$readme_content" >"$directory/README.md"
		echo "Created README.md"
	else
		echo "README.md was not created (mode set to no)."
	fi
}

# Call the function
create_project_directory

# Completion Message
echo "Project setup is complete for $(date +"%Y-%m-%d %H:%M:%S")"

# Exit Status
exit 0
