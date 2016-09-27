if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

eval "$(thefuck --alias)"
alias bf='cut -c 46-' 
export HOMEBREW_NO_ANALYTICS=1
setTerminalText () {
    # echo works in bash & zsh
    local mode=$1 ; shift
    echo -ne "\033]$mode;$@\007"
}
stt_both  () { setTerminalText 0 $@; }
stt_tab   () { setTerminalText 1 $@; }
stt_title () { setTerminalText 2 $@; }

function mt() {
  DISABLE_AUTO_TITLE="true"
  echo -e "\033];$1\007"
  mosh "$1" -- tmux a -d
}

export ANDROID_HOME=/usr/local/opt/android-sdk
export CURRENT_OS=$(uname)
export SCM_ALLOW_INSECURE=true
# virtualenv
source ~/repos/antigen/antigen.zsh
source /usr/local/opt/autoenv/activate.sh
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
    source /usr/local/Cellar/nvm/0.32.0/nvm.sh
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

if which pyenv > /dev/null; then 
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# added by travis gem
[ -f /Users/scwill/.travis/travis.sh ] && source /Users/scwill/.travis/travis.sh

# Evaluate system PATH
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
