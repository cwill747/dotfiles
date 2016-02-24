if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
export CURRENT_OS=$(uname)
source ~/repos/antigen/antigen.zsh
antigen bundle robbyrussell/oh-my-zsh lib/

antigen bundle git
antigen bundle node
antigen bundle npm
antigen bundle github
antigen bundle vagrant
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle rupa/z 
antigen bundle frodenas/cf-zsh-autocomplete-plugin

if [[ $CURRENT_OS == 'Darwin' ]]; then
    source /usr/local/Cellar/nvm/0.30.1/nvm.sh
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle gem
    antigen bundle osx
fi

antigen theme wesbos/Cobalt2-iterm cobalt2.zsh-theme

antigen apply
