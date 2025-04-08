if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

fastfetch

eval "$(pay-respects bash --alias)"
eval "$(pay-respects zsh --alias)"
pay-respects fish --alias wda | source

## thefuck --alias | source