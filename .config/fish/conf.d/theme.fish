# ~/.config/fish/conf.d/theme.fish

if not set -q __theme_mode
    set -U __theme_mode dark
end

function __apply_theme --description "Apply fish theme by mode"
    set -l mode $argv[1]

    if test -z "$mode"
        set mode $__theme_mode
    end

    set -l theme_file ~/.config/fish/themes/$mode.fish

    if not test -f "$theme_file"
        echo "Theme file not found: $theme_file"
        return 1
    end

    source "$theme_file"
end

function theme --description "Switch fish theme"
    set -l mode $argv[1]

    if test -z "$mode"
        echo "Usage: theme <light|dark|toggle>"
        return 1
    end

    switch $mode
        case light dark
            set -U __theme_mode $mode
            __apply_theme $mode
            commandline -f repaint 2>/dev/null

        case toggle
            if test "$__theme_mode" = light
                theme dark
            else
                theme light
            end

        case '*'
            echo "Unknown theme: $mode"
            echo "Usage: theme <light|dark|toggle>"
            return 1
    end
end

# Apply saved theme on shell start
__apply_theme $__theme_mode
