# ==================
# FISH
# ==================
set -U fish_greeting


# ==================
# PROMPT
# ==================
function fish_prompt
    # Colors
    set -l normal (set_color normal)

    # Virtual environment info
    set -l venv_info ""
    if test -n "$VIRTUAL_ENV"
        set -l venv_name (basename "$VIRTUAL_ENV")
        set venv_info "($venv_name) "
    end

    # Current directory with shortening
    set -l pwd_info ""
    set -l current_dir (pwd)

	 if test "$current_dir" = "$HOME"
        set -l username (whoami)
        set pwd_info "$username"
    else
        set -l dir_name (basename "$current_dir")
        set -l relative_path (string replace "$HOME/" "" "$current_dir")

        if test "$relative_path" != (basename "$relative_path")
            set pwd_info "~/…/$dir_name"
        else
            set pwd_info "~/$dir_name"
        end
    end

    # Git branch info
    set -l git_branch ""
    if git rev-parse --git-dir >/dev/null 2>&1
        set git_branch (git branch --show-current 2>/dev/null)
        if test -n "$git_branch"
            set git_branch " [$git_branch]"
        end
    end

    echo -n "$normal$venv_info$pwd_info$git_branch ) "
end



# ==================
# PATH CONFIGURATION
# ==================
# restore system PATH safely
set -l system_path /usr/local/bin /usr/bin /bin /usr/sbin /sbin

# now add your custom paths on TOP OF system paths
set -gx PATH \
    /Users/tokyo/.bun/bin \
    /opt/homebrew/bin \
    $HOME/go/bin \
    $HOME/.local/bin/nvim/bin \
    $HOME/.local/bin \
    $HOME/.cargo/bin \
    $HOME/.luarocks/bin \
    $PATH \
    $system_path 


# ==================
# PYTHON ENVIRONMENT
# ==================
set -Ux PYENV_ROOT $HOME/.pyenv
set -Ux PATH $PYENV_ROOT/bin $PATH
status --is-interactive; and pyenv init --path | source
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source
alias brew="env PATH=(string replace (pyenv root)/shims '' \"$PATH\") brew"


# ==================
# ALIASES
# ==================


# =================
# DEVELOPMENT TOOLS
# =================
# OrbStack integration
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
