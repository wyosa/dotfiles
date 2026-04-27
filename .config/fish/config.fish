# ==================
# FISH
# ==================
set -U fish_greeting

# ==================
# PATH CONFIGURATION
# ==================
fish_add_path /Users/tokyo/.bun/bin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.local/bin/nvim/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.luarocks/bin

# ==================
# PYTHON ENVIRONMENT
# ==================
set -gx PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

if status is-interactive
    pyenv init --path | source
    pyenv init - | source
    pyenv virtualenv-init - | source
end

alias brew='env PATH=(string replace (pyenv root)/shims "" "$PATH") brew'

# ==================
# PROMPT
# ==================
function fish_prompt
    set -l normal (set_color normal)

    # Virtual environment info
    set -l venv_info ""
    if test -n "$VIRTUAL_ENV"
        set -l venv_name (basename "$VIRTUAL_ENV")
        set venv_info "($venv_name) "
    end

    # Current directory info
    set -l current_dir (pwd)
    set -l pwd_info ""

    if test "$current_dir" = "$HOME"
        set pwd_info (whoami)
    else if string match -q "$HOME/*" "$current_dir"
        set -l relative_path (string replace "$HOME/" "" "$current_dir")
        set -l dir_name (basename "$current_dir")

        if test "$relative_path" = "$dir_name"
            set pwd_info "~/$dir_name"
        else
            set pwd_info "~/…/$dir_name"
        end
    else
        set pwd_info "$current_dir"
    end

    # Git branch info
    set -l git_branch ""
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set git_branch (git branch --show-current 2>/dev/null)

        if test -n "$git_branch"
            set git_branch " [$git_branch]"
        end
    end

    echo -n "$normal$venv_info$pwd_info$git_branch ) "
end

# ==================
# ALIASES
# ==================

# ==================
# DEVELOPMENT TOOLS
# ==================
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
