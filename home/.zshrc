source ~/.zshrc.local

lazy_source () {
    eval "$1 () { [ -f $2  ] && source $2 && $1 \$@  }"
}

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

export CURRENT_OS=$(uname)
export SCM_ALLOW_INSECURE=true
# virtualenv
# source $HOME/repos/antigen/antigen.zsh
source $HOME/.rvm/scripts/rvm
ZSH_THEME="agnoster"
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/node
    zgen oh-my-zsh plugins/npm
    zgen oh-my-zsh plugins/github
    zgen oh-my-zsh plugins/vagrant
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-history-substring-search
    zgen load rupa/z
    zgen load agnoster/agnoster-zsh-theme

    zgen save
fi

if [[ $CURRENT_OS == 'Darwin' ]]; then
#    antigen bundle brew
#    antigen bundle brew-cask
#    antigen bundle gem
#    antigen bundle osx
    source /usr/local/opt/autoenv/activate.sh
    export ANDROID_HOME=$(brew --prefix android-sdk)
fi

if [[ $CURRENT_OS == 'Linux' ]]; then
    source ~/.autoenv/activage.sh
fi

NODE_VERSION="v7.2.0"
. "$NVM_DIR/nvm.sh" --no-use
export PATH="${PATH}:${NVM_DIR}/versions/node/${NODE_VERSION}/bin"
# [ -s "$NVM_DIR/nvm.sh"  ] && source "$NVM_DIR/nvm.sh"
export PATH="$HOME/.yarn/bin:$PATH"


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


### Added by the Bluemix CLI
source /usr/local/Bluemix/bx/zsh_autocomplete
