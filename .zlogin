#!/bin/zsh
################################################################################
#                            spease's zlogin file v1.0.2 
#
#
################################################################################

################################################################################
# Check if we have any updates
# 
# 

check-for-updates() {
    lines=$(git -C $HOME/.dotfiles/dotfiles fetch --dry-run 2>&1 \
        | wc -l | tr -d ' ')
    if [[ "X$lines" != "X0" ]]; then
        printf "\rYou have pending dotfile updates.\n\r"
        print -nP "$PS1"
    fi
}

(check-for-updates &)
