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
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'

# tab選択中のプロンプト
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# compctlを利用する
#zstyle ':completion:*' use-compctl false

# 詳細を表示する
# コマンドのメニュー補完で右側に表示される詳細
zstyle ':completion:*' verbose true

# killの補完
# fzfとバッティングしているのでコメントアウト
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
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
### End of Zinit's installer chunk

# zinitプラグイン
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# ロードされなかったDL済みのプラグインを削除する
function delete_plugins() {
	local downloaded=$(zinit zstatus | grep Downloaded | awk -F ": " '{print $2}')
	local loaded=$(zinit zstatus | grep Loaded | awk -F ": " '{print $2}')
	if [[ $downloaded != $loaded ]]; then
		zinit delete --clean
	fi
}
delete_plugins
# ------------------- zinit設定 ここまで -------------------- #


# '.p10k.zsh'読み込み
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ghq + fzf 
function fzf_src () {
  local selected_dir=$(ghq list -p | fzf)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf_src
bindkey '^]' fzf_src

# alias
alias ls='ls --color=auto'
alias ll='ls -alF'
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias aud='sudo apt update'
alias aug='sudo apt upgrade -y'
alias al='sudo apt list --upgradable'

# path
typeset -U path
path=(~/gibo(N-/) ~/go/bin(N-/) $path)

# ------------------- sdkman設定 ここから -------------------- #
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
# ------------------- sdkman設定 ここまで -------------------- #

eval "$(starship init zsh)"
