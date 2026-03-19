if not set -q __theme_mode
    set -U __theme_mode dark
end

function __apply_theme --description "Apply fish theme by mode"
    set -l mode $argv[1]
    if test -z "$mode"
        set mode $__theme_mode
    end

    switch $mode
        case light
            # --- LIGHT THEME  ---
            set -g fish_color_normal normal

            # Commands / keywords
            set -g fish_color_command normal
            set -g fish_color_keyword normal

            # Arguments / options
            set -g fish_color_param normal
            set -g fish_color_option normal

            # Operators / redirections / escapes
            set -g fish_color_operator normal
            set -g fish_color_redirection normal
            set -g fish_color_escape normal
            set -g fish_color_end normal

            # Comments and autosuggestions (gray)
            set -g fish_color_comment 6a6a6a
            set -g fish_color_autosuggestion 8a8a8a

            # Errors
            set -g fish_color_error normal

            # Paths
            set -g fish_color_cwd normal
            set -g fish_color_cwd_root red
            set -g fish_color_valid_path --underline

            # Selection / search highlight
            set -g fish_color_search_match --background=brblack --bold
            set -g fish_color_selection --background=brblack --bold

            # Pager (completion UI)
            set -g fish_pager_color_completion normal
            set -g fish_pager_color_description 6a6a6a
            set -g fish_pager_color_prefix normal --bold --underline
            set -g fish_pager_color_progress normal --bold --background=brblack
            set -g fish_pager_color_selected_background --background=brblack

            # ---------------------------------------------------------
        case dark
            # --- DARK THEME (вставь сюда своё) ---
            # set -g fish_color_command brgreen
            # set -g fish_color_param normal
            # ------------------------------------
        case '*'
            set -U __theme_mode dark
            __apply_theme dark
            return
    end
end

function theme-light --description "Switch fish theme to light (persist)"
    set -U __theme_mode light
    __apply_theme light
    commandline -f repaint 2>/dev/null
end

function theme-dark --description "Switch fish theme to dark (persist)"
    set -U __theme_mode dark
    __apply_theme dark
    commandline -f repaint 2>/dev/null
end

function theme-toggle --description "Toggle fish theme (persist)"
    if test "$__theme_mode" = light
        theme-dark
    else
        theme-light
    end
end

# apply on shell start
__apply_theme $__theme_mode
