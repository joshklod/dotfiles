SHRC_SHELL=zsh

[[ -o login ]]         && SHRC_LOGIN=true
[[ -o interactive ]]   && SHRC_INTERACTIVE=true

emulate sh -c '. "$HOME/.shrc.sh"'
