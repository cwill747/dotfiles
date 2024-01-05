alias ev 'vim ~/.config/nvim/init.vim'
alias ea 'vim ~/.config/fish/aliases.fish'
alias ef 'vim ~/.config/fish/config.fish'

alias ibrew 'arch -x86_64 /usr/local/homebrew/bin/brew'
alias mbrew 'arch -arm64 /opt/homebrew/bin/brew'
alias brew 'mbrew'

if type -q bat
    alias cat 'bat'
end

alias vim="nvim"
alias vi="nvim"
alias oldvim="\vim"
alias ssh="TERM=xterm-256color /usr/bin/ssh"
function cleanpycs
    find . -name '.git' -prune -o -name '__pycache__' -delete
    find . -name '.git' -prune -o -name '*.py[co]' -delete
end

alias asdf='mise'
alias rtx='mise'
alias yadm='chezmoi'

