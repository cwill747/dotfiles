set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_behind '↓'
set __fish_git_prompt_char_upstream_ahead '↑'


function fish_prompt
  set last_status $status
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname -s)
  end
  set_color red
  echo -n -s "$USER" @ "$__fish_prompt_hostname" " "
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  set_color normal
end

set -x PATH $PATH $HOME"/.config/yarn/global/node_modules/.bin" "/usr/local/sbin" $HOME"/go/bin" $HOME"/.cargo/bin"

set -x GOPATH $HOME/go

eval (direnv hook fish)

status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)
