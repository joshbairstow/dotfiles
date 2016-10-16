autoload -Uz vcs_info

# currently dot indicators mark: red (untracked), yellow (unstaged), green (uncommited), purple (unpushed)
# format escapes: %c - stagedstr, %u - unstagedstr
zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
# set to debug boolean to true to print hook runtime information
zstyle ':vcs_info:*+*:*' debug false

# hooks functionality via:
# https://github.com/mayth/dotfiles/blob/master/zshfiles/vcs_info.zsh
zstyle ':vcs_info:git+set-message:*' hooks git-hook-begin git-push-status # git-untracked git-nomerge-branch git-stash-count

# hook functions are called if there are working copy of git (not in .git directory)
function +vi-git-hook-begin() {
  if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
    # hook functions after this will not be called if not 0 is returned.
    return 1
  fi

  return 0
}

# append '?' to `unstaged (%u)` if there are any untracked files.
function +vi-git-untracked() {
  # targets 2nd message in zstyle formats, actionformats
  if [[ "$1" != "1" ]]; then
    return 0
  fi

  if command git status --porcelain 2> /dev/null \
    | awk '{print $1}' \
    | command grep -F '??' > /dev/null 2>&1 ; then
    # append to unstaged (%u)
    hook_com[unstaged]+='?'
  fi
}

# append 'pN', N is a number of un-pushed commits, to `misc (%m)`
function +vi-git-push-status() {
  # targets 2nd message in zstyle formats, actionformats
  # NB: have disabled currently as not sure what zstyle formats this refers to
  # if [[ "$1" != "1" ]]; then
  #   return 0
  # fi

  if [[ "${hook_com[branch]}" != "master" ]]; then
    # io nothing if it is not master branch
    return 0
  fi

  # get number of commits that un-pushed
  local ahead
  ahead=$(command git rev-list origin/master..master 2>/dev/null \
    | wc -l \
    | tr -d ' ')

  if [[ "$ahead" -gt 0 ]]; then
    # append to misc (%m)
    hook_com[misc]+='%F{magenta}●'
  fi
}

# show mN in misc (%m). N is number of commits in current branch that is not merged to master.
function +vi-git-nomerge-branch() {
  # targets 2nd message in zstyle formats, actionformats
  if [[ "$1" != "1" ]]; then
    return 0
  fi

  if [[ "${hook_com[branch]}" == "master" ]]; then
    # do nothing if it is master branch
    return 0
  fi

  local nomerged
  nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

  if [[ "$nomerged" -gt 0 ]] ; then
    # append to misc (%m)
    hook_com[misc]+="(m${nomerged})"
  fi
}

# show :SN in misc (%m). N is a number of stashes
function +vi-git-stash-count() {
  # targets 2nd message in zstyle formats, actionformats
  if [[ "$1" != "1" ]]; then
    return 0
  fi

  local stash
  stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
  if [[ "${stash}" -gt 0 ]]; then
    # append to misc (%m)
    hook_com[misc]+=":S${stash}"
  fi
}

theme_precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '%F{blue}( %b %u%c%m%%b%F{blue} )'
    } else {
        zstyle ':vcs_info:*' formats '%F{blue}( %b %F{red}●%u%c%m%%b%F{blue} )'
    }

    vcs_info
}

# display current working directory
function current_dir() {
  local dir_name=%c
  echo $dir_name
}

function print_dir() {
  local dir_output="%{$fg[cyan]%}( $(current_dir) )"
  echo $dir_output
}

# display user, machine, and ssh info if not default
print_context() {
  local context_details=""
  if [[ -n "$SSH_CLIENT" ]]; then
    context_details+="%{$fg[red]%}[ SSH ]"
  fi
  if [[ "$USER" != "$DEFAULT_USER" ]]; then
    context_details="%{$fg[red]%}( %{$fg[yellow]%}$USER%{$fg[red]%}@%{$fg[yellow]%}%m %{$fg[red]%})"
  fi
  echo $context_details
}

# length calculation functions
function current_git_length() {
  local git_value=${vcs_info_msg_0_}
  local git_length
  local git_status="dirty"

  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    git_status="clean"
  fi

  if [ ${#git_value} != 0 ]; then
    if [ $git_status = "clean" ]; then
      (( git_length = ${#git_value} - 27 ))
    else
      (( git_length = ${#git_value} - 34 ))
    fi
  else
    git_length=0
  fi
  echo $git_length
}
function current_dir_length() {
  local dir_value="$(print_dir)"
  local zero='%([BSUbfksu]|([FB]|){*})'
  local dir_length=${#${(S%%)dir_value//$~zero/}}
  echo $dir_length
}
function current_context_length() {
  local context_value="$(print_context)"
  local zero='%([BSUbfksu]|([FB]|){*})'
  local context_length=${#${(S%%)context_value//$~zero/}}
  echo $context_length
}
function current_node_length() {
  local node_value="$(print_node)"
  local zero='%([BSUbfksu]|([FB]|){*})'
  local node_length=${#${(S%%)node_value//$~zero/}}
  echo $node_length
}
function current_ruby_length() {
  local ruby_value=$(current_ruby)
  local ruby_length
  if [ ${#ruby_value} != 0 ]; then
    (( ruby_length = ${#ruby_value} + 4 ))
  else
    ruby_length=0
  fi
  echo $ruby_length
}

# find and output spacing between left and right prompt elements
function print_spacer() {
  local prompt_left
  (( prompt_left = $(current_context_length) + $(current_git_length) + $(current_dir_length) ))
  local prompt_right
  (( prompt_right = $(current_node_length) + $(current_ruby_length) ))
  local prompt_separation
  (( prompt_separation = ${COLUMNS} - $prompt_left - $prompt_right ))

  local spacer=""
  for i in {1..$prompt_separation}; do
    spacer="${spacer} "
  done

  echo $spacer
}

# display current node env information
function print_node() {
  local node_info="%{$fg[green]%}( node-$(nvm_prompt_info) )%{$reset_color%}"
  echo $node_info
}

# display current ruby env information
function current_ruby() {
  local current_ruby=$(rvm current 2>/dev/null || rbenv version-name 2>/dev/null)
  echo $current_ruby
}
function print_ruby() {
  local ruby_info="%{$fg[yellow]%}( %{$(current_ruby)%} )"
  echo $ruby_info
}

# generate prompt indicator color based ond last exit status
function print_status_prompt() {
  local exit_status_color="%(?.%{$fg[white]%}.%{$fg[red]%})%"
  local status_prompt=$exit_status_color+" ▶▶▶ "
  echo $status_prompt
}

# setopt prompt_subst
PROMPT='
$(print_context)${vcs_info_msg_0_}$(print_dir)$(print_spacer)$(print_node)$(print_ruby)
$(print_status_prompt)$reset_color'

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
