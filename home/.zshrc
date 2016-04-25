if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
eval "$(thefuck --alias)"
alias bf='cut -c 46-' 
export ANDROID_HOME=/usr/local/opt/android-sdk
export CURRENT_OS=$(uname)
export SCM_ALLOW_INSECURE=true
# virtualenv
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
    source /usr/local/bin/virtualenvwrapper.sh
    source /usr/local/Cellar/nvm/0.30.1/nvm.sh
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle gem
    antigen bundle osx

fi

antigen theme wesbos/Cobalt2-iterm cobalt2.zsh-theme

antigen apply

PATH="/Users/scwill/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/Users/scwill/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/scwill/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/scwill/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/scwill/perl5"; export PERL_MM_OPT;

eval "$(pyenv init -)"

# added by travis gem
[ -f /Users/scwill/.travis/travis.sh ] && source /Users/scwill/.travis/travis.sh
