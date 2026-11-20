ZSH=$HOME/.oh-my-zsh

# # 20231027 1952: Add olist path to your PYTHONPATH to easily import modules defined in olist in the notebooks
# export PYTHONPATH="/home/robert/code/RobertFranc/04-Decision-Science/01-Project-Setup/data-context-and-setup:$PYTHONPATH"
# export PYTHONPATH="/home/robert/code/RobertFranc/04-Decision-Science/01-Project-Setup:$PYTHONPATH"
# export PYTHONPATH="C:/Users/user/Documents:$PYTHONPATH"

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="avit" # https://github.com/ohmyzsh/ohmyzsh/blob/31eca46ee3b94ca84a038628e0bf6089a7488908/themes/avit.zsh-theme#L60-L70
  # Meaning of the icons: https://www.reddit.com/r/zsh/comments/g31jdm/ohmyzsh_themeicon_documentation/
    # The time is time since last commit.
    # Red x: dirty repo
    # Yellow flag: modified files
    # Green plus: added files
    # Half moon: untracked files
    # Red ø-like symbol: last command returned non-zero

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search ssh-agent direnv)

# 20261125 <<<<<<< ours
# # (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
# export HOMEBREW_NO_ANALYTICS=1
# 20261125 =======
# Add the omz ssh-agent plugin for WSL / Linux only (macOS handles this through Keychain in ~/.ssh/config)
case "$(uname -s)" in
  Darwin) ;;
  Linux)  plugins+=('ssh-agent') ;;
esac

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1
# 20261125 >>>>>>> theirs

# Disable warning about insecure completion-dependent directories
ZSH_DISABLE_COMPFIX=true

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)
unalias lt # we need `lt` for https://github.com/localtunnel/localtunnel

# # Load rbenv if installed (to manage your Ruby versions)
# export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
# type -a rbenv > /dev/null && eval "$(rbenv init -)"

# -----------------------------------------------------------------------------
# 20260228: Default interpreter path '~/.pyenv/shims/python' could not be resolved: Could not resolve interpreter path '~/.pyenv/shims/python'
#           Source: Python Environments
# Google Search AI suggestion:
# On Linux/WSL, .bashrc settings only apply to the Bash shell.
# When using Zsh (which is common if using "Oh My Zsh"), the shell ignores the .bashrc file entirely.
# Therefore, just like that of .bashrc, add those same pyenv configuration lines:
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# When done, Crucial: Run source ~/.zshrc to update the current terminal, or simply restart VS Code.
# Before checking the VS Code UI, type in Zsh terminal: which python
# Success: It should return /home/yourusername/.pyenv/shims/python.
# Failure: If it returns /usr/bin/python, the configuration didn't load.
# -----------------------------------------------------------------------------

# Load pyenv (to manage your Python versions)
# 20261125 <<<<<<< ours
# 20261125 export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init - 2> /dev/null)" && RPROMPT+='[🐍 $(pyenv version-name)]'
# 20261125 type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init - 2> /dev/null)" && RPROMPT+='[🗾life😅code $(pyenv version-name)]'
# -----------------------------------------------------------------------------
# 20260321 0830 TODO: resolve this message:
# Default interpreter path 'C:\Users\user\anaconda3\python.exe' could not be resolved: Could not resolve interpreter path 'C:\Users\user\anaconda3\python.exe'
# -----------------------------------------------------------------------------
# 20261125 =======
# Uncomment the next lines if you still run a pyenv based setup
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init - 2> /dev/null)" && RPROMPT+='[🐍 $(pyenv version-name)]'
# 20261125 >>>>>>> theirs
# Load nvm (to manage your node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Call `nvm use` automatically in a directory with a `.nvmrc` file
autoload -U add-zsh-hook
load-nvmrc() {
  if nvm -v &> /dev/null; then
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use --silent
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      nvm use default --silent
    fi
  fi
}
type -a nvm > /dev/null && add-zsh-hook chpwd load-nvmrc
type -a nvm > /dev/null && load-nvmrc

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export BUNDLER_EDITOR=code
export EDITOR=code

# Set ipdb as the default Python debugger
export PYTHONBREAKPOINT=ipdb.set_trace

# 20261125 <<<<<<< ours
export BROWSER="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe"
export GH_BROWSER="'/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe'"
# C:\Program Files\Mozilla Firefox\firefox.exe
# export BROWSER="/mnt/c/Program\ Files\Mozilla Firefox\firefox.exe"
# export GH_BROWSER="/mnt/c/Program\ Files\Mozilla Firefox\firefox.exe"
export GOOGLE_APPLICATION_CREDENTIALS=~/code/RobertFranc/00-Setup/le-wagon-20240120-0d4fb56c6925.json

# -----------------------------------------------------------------------------
# 20260307:
#  Automatically connect WSL2 to Windows X-Server (VcXsrv)
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
export LIBGL_ALWAYS_INDIRECT=1

# Automatically find Windows IP and set the Webcam Variable
WIN_IP=$(ip route show | grep -i default | awk '{print $3}')
if [ -n "$WIN_IP" ]; then
  export MY_CAM_SOURCE="http://${WIN_IP}:5000/video"
fi
export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk "{print \$2}"):0.0
# -----------------------------------------------------------------------------

# 20261125 keep both =======

# Activate the Le Wagon Python venv and update the prompt
LW_VENV="$HOME/.lewagon/venvs/lewagon"
if [ -e $LW_VENV ]; then
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  source $LW_VENV/bin/activate
  RPROMPT+='[🐍 $VIRTUAL_ENV_PROMPT]'
fi

# Hook direnv but only if direnv is installed
if (( $+commands[direnv] )); then eval "$(direnv hook zsh)"; fi
# 20261125 >>>>>>> theirs