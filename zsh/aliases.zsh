# reload zsh config
alias reload!='source ~/.zshrc'

alias vim="nvim"

# Filesystem aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

alias l="ls -lah ${colorflag}"
alias ls="ls -lah ${colorflag}"
alias la="ls -AF ${colorflag}"
alias ll="ls -lFh ${colorflag}"
alias lld="ls -l | grep ^d"
alias rmf="rm -rf"

# local for work
alias sshBuildslave="ssh -i ~/.ssh/sydney.pem ubuntu@buildslave.dev.nbvcloud.com"
alias sshBuildmaster="ssh -i ~/.ssh/sydney.pem ec2-user@zonea.webapp.dev.nbvcloud.com"
alias removeUntaggedImages="docker rmi $(docker images -q --filter "dangling=true")"
