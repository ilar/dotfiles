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

internal_ilar_var_cwd=$(pwd)
cd $DOTFILES_DIR
lines=$(git fetch --dry-run | wc -l | tr -d ' ')
if [[ "X$lines" != "X0" ]]; then
    echo "You have pending dotfile updates."
fi
