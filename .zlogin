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
    if [ $(which git > /dev/null) = 0 ]; then
        lines=$(git -C $HOME/.dotfiles/dotfiles fetch --dry-run 2>&1 \
            | wc -l | tr -d ' ')
        if [[ "X$lines" != "X0" ]]; then
            printf "\rYou have pending dotfile updates.\n\r"
            print -nP "$PS1"
        fi
    fi
}

(check-for-updates &)
