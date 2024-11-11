# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export JAVA_HOME=$(/usr/libexec/java_home -v 17)

# Export locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Mac aliases
alias emacs='emacs -nw'
alias vim='nvim'
alias disablesleep="sudo pmset -a disablesleep 1"
alias enablesleep="sudo pmset -a disablesleep 0"
alias list-users="dscl . list /Users | grep -v '^_'"
alias find-ports="sudo lsof -i -n -P | grep TCP"
alias brew-update="brew update && brew upgrade"
alias pomodoro="termdown 60m && termdown 5m -s -t Done"
alias rm='echo "This is not the command you are looking for."; false'
alias backup-configs="cd ~/workspace/configurations/ && ./backup.sh"
alias backup-diary="cd ~/workspace/diary/ && git status"
alias connect-tab-s8='scrcpy --tcpip=192.168.178.26:38163'

# Git aliases
alias git-root='cd $(git rev-parse --show-toplevel)'
alias git-count='git shortlog -s -n'
alias git-pull-develop='git checkout develop && git fetch && git pull && git checkout -'
alias gln='git log --name-only'
alias gdn='git diff --name-only'

# Exporter environemnt aliases
alias ngrok-start="ngrok start --all"
front_end_dir() {
  cd $HOME/scroll-exporters/scroll-exporter-ui/src/main/frontend/
}
alias yarn-start="front_end_dir && yarn run start"

# JAVA aliases
alias j21="export JAVA_HOME=`/usr/libexec/java_home -v 21`; java -version"
alias j20="export JAVA_HOME=`/usr/libexec/java_home -v 20`; java -version"
alias j19="export JAVA_HOME=`/usr/libexec/java_home -v 19`; java -version"
alias j18="export JAVA_HOME=`/usr/libexec/java_home -v 18`; java -version"
alias j17="export JAVA_HOME=`/usr/libexec/java_home -v 17`; java -version"
alias j16="export JAVA_HOME=`/usr/libexec/java_home -v 16`; java -version"
alias j15="export JAVA_HOME=`/usr/libexec/java_home -v 15`; java -version"
alias j14="export JAVA_HOME=`/usr/libexec/java_home -v 14`; java -version"
alias j13="export JAVA_HOME=`/usr/libexec/java_home -v 13`; java -version"
alias j12="export JAVA_HOME=`/usr/libexec/java_home -v 12`; java -version"
alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
alias j10="export JAVA_HOME=`/usr/libexec/java_home -v 10`; java -version"
alias j9="export JAVA_HOME=`/usr/libexec/java_home -v 9`; java -version"
alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
alias j7="export JAVA_HOME=`/usr/libexec/java_home -v 1.7`; java -version"

# Confluence start aliases
alias confluence-9-02-start-fg="j17 && ~/confluence/atlassian-confluence-9.0.2/bin/start-confluence.sh -fg"
alias confluence-9-02-start="j17 && ~/confluence/atlassian-confluence-9.0.2/bin/start-confluence.sh"
alias confluence-9-02-stop="~/confluence/atlassian-confluence-9.0.2/bin/stop-confluence.sh"
alias confluence-8-57-start-fg="j11 && ~/confluence/atlassian-confluence-8.5.7/bin/start-confluence.sh -fg"
alias confluence-8-57-start="j11 && ~/confluence/atlassian-confluence-8.5.7/bin/start-confluence.sh"
alias confluence-8-57-stop="~/confluence/atlassian-confluence-8.5.7/bin/stop-confluence.sh"
alias confluence-7-19-start-fg="j11 && ~/confluence/atlassian-confluence-7.19.1/bin/start-confluence.sh -fg"
alias confluence-7-19-start="j11 && ~/confluence/atlassian-confluence-7.19.1/bin/start-confluence.sh"
alias confluence-7-19-stop="~/confluence/atlassian-confluence-7.19.1/bin/stop-confluence.sh"

# Jira start stop aliases
alias jira-start="j11 && ~/jira/atlassian-jira-core-9.12.8-standalone/bin/start-jira.sh"
alias jira-stop="~/jira/atlassian-jira-core-9.12.8-standalone/bin/stop-jira.sh"

# Maven aliases
alias mvn-pack='mvn -T 4C clean install -Dlicense.skipDownloadLicenses -DskipTests'
alias mvn-werk='mvn -T 4C clean compile -Dlicense.skipDownloadLicenses'
alias mvn-fast='mvn -T 4C clean compile -Dlicense.skipDownloadLicenses -DskipTests'
alias mvn-off='mvn -T 4C -q clean compile -Dlicense.skipDownloadLicenses -DskipTests -am -offline'

# Oh-my-zsh configurations
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Ngrok configurations
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# Oh-my-posh theme configurations
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/marcduiker.omp.json)"

# Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
