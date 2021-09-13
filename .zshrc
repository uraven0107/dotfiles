# p10k使うのに必要
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# vimキーバインド
bindkey -v

# ヒストリーに重複を表示しない
setopt histignorealldups 
# 他のタブ、ウィンドウとコマンド履歴を共有する
setopt sharehistory
# ディレクトリ名を入力だけでcd実行
setopt auto_cd
# cdしたら自動的にpushd
setopt auto_pushd
# ctrl+sのロック、ctrl+qのロック解除を無効化
setopt no_flow_control

# コマンド履歴を'.zsh_history'に1000まで保存する
HISTSIZE=10000 # メモリに保存される履歴の件数
SAVEHIST=10000 # 履歴ファイルに保存される履歴の件数
HISTFILE=~/.zsh_history

# コマンドライン補完機能を有効化して実行
autoload -Uz compinit && compinit

# ------------------- zsh補完設定 ここから -------------------- #

# これなに
zstyle ':completion:*' auto-description 'specify: %d'

# 補完用の関数(completer)を指定する。
zstyle ':completion:*' completer _expand _complete _correct _approximate

# 補完時にformatで指定した文字列がマッチ種別一覧で表示されるようになる。
zstyle ':completion:*' format '<<<=================== Completing %d ===================>>>'

# マッチ種別を別々に表示する。これが無いと、補完時にマッチ種別一覧→マッチ内容の順で表示されてしまう。
zstyle ':completion:*' group-name ''

# メニュー補完(tabで補完候補を順に挿入してくれるやつ)を利用する
# select=2 補完候補が2つ以上なければすぐに補完してくれる
zstyle ':completion:*' menu select=2
# select=long 補完候補がスクリーンに映らない場合にリスト形式で表示して、カーソルで選択できる。
#zstyle ':completion:*' menu select=long

# 環境変数LS_COLORSをexport
eval "$(dircolors -b)"
# 補完候補一覧の色を設定
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ''

# 補完候補一覧表示のプロンプト
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s

# あいまい検索
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# 小文字→大文字
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 

# tab選択中のプロンプト
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# compctlを利用する
zstyle ':completion:*' use-compctl false

# 詳細を表示する
# コマンドのメニュー補完で右側に表示される詳細
zstyle ':completion:*' verbose true

# killの補完
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# ------------------- zsh補完設定 ここまで -------------------- #


# ------------------- zinit設定 ここから -------------------- #
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# zinitプラグイン
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/history-search-multi-word
zinit light supercrabtree/k
# ------------------- zinit設定 ここまで -------------------- #


# '.p10k.zsh'読み込み
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ghq + peco
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# alias
alias ls='ls --color=auto'
alias ll='ls -alF'
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

# path
export PATH=$PATH:~/gibo:~/go/bin


# ------------------- sdkman設定 ここから -------------------- #
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/uraven/.sdkman"
[[ -s "/home/uraven/.sdkman/bin/sdkman-init.sh" ]] && source "/home/uraven/.sdkman/bin/sdkman-init.sh"
# ------------------- sdkman設定 ここまで -------------------- #
