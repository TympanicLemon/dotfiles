# Set PATH
set -gx PATH /opt/homebrew/bin $PATH
set -U fish_user_paths ~/.local/share/bob/nvim-bin $fish_user_paths

# Set editor for local and remote sessions
if set -q SSH_CONNECTION
    set -gx EDITOR vim
else
    set -gx EDITOR nvim
end

# Aliases
alias ls='eza'
alias gg='lazygit'
alias conf='cd ~/.config/nvim && nvim'

# School
alias hws='/Users/danielz/Library/CloudStorage/OneDrive-MiraCostaCollege/CS\ 220/nand2tetris/tools/HardwareSimulator.sh'
alias cpu='/Users/danielz/Library/CloudStorage/OneDrive-MiraCostaCollege/CS\ 220/nand2tetris/tools/CPUEmulator.sh'
alias asmb='/Users/danielz/Library/CloudStorage/OneDrive-MiraCostaCollege/CS\ 220/nand2tetris/tools/Assembler.sh'
alias jackc='/Users/danielz/Library/CloudStorage/OneDrive-MiraCostaCollege/CS\ 220/nand2tetris/tools/JackCompiler.sh'
alias vme='/Users/danielz/Library/CloudStorage/OneDrive-MiraCostaCollege/CS\ 220/nand2tetris/tools/VMEmulator.sh'

# Functions
function dot
    cd ~/dotfiles
    set file (find . -type f ! -path "*/.git/*" | fzf --height 40% --border)
    [ -n "$file" ]; and nvim "$file"
end

function sp
    cd ~/Projects
    set category (find . -mindepth 1 -maxdepth 1 -type d ! -path "*/.*" | sed "s|^\./||" | fzf --height 40% --border)
    [ -n "$category" ]; and cd "$category"
    set project (find . -mindepth 1 -maxdepth 1 -type d ! -path "*/.*" | sed "s|^\./||" | fzf --height 40% --border)
    [ -n "$project" ]; and cd "$project"
end

function s210
    cd "/Users/danielz/Library/CloudStorage/OneDrive-MiraCostaCollege/CS 210"
    set dir (find . -type d ! -path "*/.git/*" | fzf --height 40% --border)
    [ -n "$dir" ]; and cd "$dir" && nvim
end

function s220
    cd "/Users/danielz/Library/CloudStorage/OneDrive-MiraCostaCollege/CS 220"
    set dir (find . -type d ! -path "*/.git/*" | fzf --height 40% --border)
    [ -n "$dir" ]; and cd "$dir" && nvim
end

# Fish
set -g fish_greeting ""

# Starship
set -gx STARSHIP_CONFIG ~/dotfiles/starship.toml
starship init fish | source
enable_transience

# Zoxide
zoxide init fish | source
