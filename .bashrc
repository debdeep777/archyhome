#This ia another fiel
# =============================================================== #
#
# PERSONAL $HOME/.bashrc FILE for bash-3.0 (or later)
# By Emmanuel Rouat [no-email]
#
# Last modified: Tue Nov 20 22:04:47 CET 2012

#  This file is normally read by interactive shells only.
#+ Here is the place to define your aliases, functions and
#+ other interactive features like your prompt.
#
#  The majority of the code here assumes you are on a GNU
#+ system (most likely a Linux box) and is often based on code
#+ found on Usenet or Internet.
#
#  See for instance:
#  http://tldp.org/LDP/abs/html/index.html
#  http://www.caliban.org/bash
#  http://www.shelldorado.com/scripts/categories.html
#  http://www.dotfiles.org
#
#  The choice of colors was done for a shell with a dark background
#+ (white on black), and this is usually also suited for pure text-mode
#+ consoles (no X server available). If you use a white background,
#+ you'll have to do some other choices for readability.
#
#  This bashrc file is a bit overcrowded.
#  Remember, it is just just an example.
#  Tailor it to your needs.
#
# =============================================================== #



# --> Comments added by HOWTO author.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.


# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset


ALERT=${BWhite}${On_Red} # Bold White on red background



# Starting message
#echo -e "${Blue}This is BASH ${Red}${BASH_VERSION%.*}${Blue}\
#- DISPLAY on ${Red}$DISPLAY${NC}"


# For fortune
#if [ -x /usr/games/fortune ]; then
#    fortune | cowsay     # Makes our day a bit more fun.... :-)
#fi

function _exit()              # Function to run upon exit of shell.
{
    echo -e "${Blue}Bye bye now.${NC}"
}
trap _exit EXIT

#-------------------------------------------------------------
# Shell Prompt - for many examples, see:
#       http://www.debian-administration.org/articles/205
#       http://www.askapache.com/linux/bash-power-prompt.html
#       http://tldp.org/HOWTO/Bash-Prompt-HOWTO
#       https://github.com/nojhan/liquidprompt
#-------------------------------------------------------------
# Current Format: [TIME USER@HOST PWD] >
# TIME:
#    Green     == machine load is low
#    Orange    == machine load is medium
#    Red       == machine load is high
#    ALERT     == machine load is very high
# USER:
#    Cyan      == normal user
#    Orange    == SU to user
#    Red       == root
# HOST:
#    Cyan      == local session
#    Green     == secured remote connection (via ssh)
#    Red       == unsecured remote connection
# PWD:
#    Green     == more than 10% free disk space
#    Orange    == less than 10% free disk space
#    ALERT     == less than 5% free disk space
#    Red       == current user does not have write privileges
#    Cyan      == current filesystem is size zero (like /proc)
# >:
#    White     == no background or suspended jobs in this shell
#    Cyan      == at least one background job in this shell
#    Orange    == at least one suspended job in this shell
#
#    Command is added to the history file each time you hit enter,
#    so it's available to all shells (using 'history -a').


# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
    CNX=${Green}        # Connected on remote machine, via ssh (good).
elif [[ "${DISPLAY%%:0*}" != "" ]]; then
    CNX=${ALERT}        # Connected on remote machine, not via ssh (bad).
else
    CNX=${BBlue}        # Connected on local machine.
fi

# Test user type:
if [[ ${USER} == "root" ]]; then
    SU=${Red}           # User is root.
#elif [[ ${USER} != $(logname) ]]; then
#    SU=${BRed}          # User is not login user.
else
    SU=${BCyan}         # User is normal (well ... most of us are).
fi



NCPU=$(grep -c 'processor' /proc/cpuinfo)    # Number of CPUs
SLOAD=$(( 100*${NCPU} ))        # Small load
MLOAD=$(( 200*${NCPU} ))        # Medium load
XLOAD=$(( 400*${NCPU} ))        # Xlarge load

# Returns system load as percentage, i.e., '40' rather than '0.40)'.
function load()
{
    local SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.')
    # System load of the current host.
    echo $((10#$SYSLOAD))       # Convert to decimal.
}

# Returns a color indicating system load.
function load_color()
{
    local SYSLOAD=$(load)
    if [ ${SYSLOAD} -gt ${XLOAD} ]; then
        echo -en ${ALERT}
    elif [ ${SYSLOAD} -gt ${MLOAD} ]; then
        echo -en ${Red}
    elif [ ${SYSLOAD} -gt ${SLOAD} ]; then
        echo -en ${BRed}
    else
        echo -en ${Green}
    fi
}

# Returns a color according to free disk space in $PWD.
function disk_color()
{
    if [ ! -w "${PWD}" ] ; then
        echo -en ${Red}
        # No 'write' privilege in the current directory.
    elif [ -s "${PWD}" ] ; then
        local used=$(command df -P "$PWD" |
                   awk 'END {print $5} {sub(/%/,"")}')
        if [ ${used} -gt 98 ]; then
            echo -en ${ALERT}           # Disk almost full (>95%).
        elif [ ${used} -gt 90 ]; then
            echo -en ${BRed}            # Free disk space almost gone.
        else
            echo -en ${Green}           # Free disk space is ok.
        fi
    else
        echo -en ${Cyan}
        # Current directory is size '0' (like /proc, /sys etc).
    fi
}

# Returns a color according to running/suspended jobs.
function job_color()
{
    if [ $(jobs -s | wc -l) -gt "0" ]; then
        echo -en ${BRed}
    elif [ $(jobs -r | wc -l) -gt "0" ] ; then
        echo -en ${BBlue}
    fi
}

# Adds some text in the terminal frame (if applicable).




PROMPT_COMMAND="history -a"
case ${TERM} in
  *term* | rxvt | linux)	# Originally: *term | rxvt | linux)
        # Time of day (with load info):
#        PS1="\[\$(load_color)\][\A\[${NC}\] "
        # User@Host (with connection type info):
        PS1="\[${SU}\]\u\[${NC}\]@\[${CNX}\]\h\[${NC}\]:"

        # PWD (with 'disk space' info):
        PS1=${PS1}"\[\$(disk_color)\]\W>\[${NC}\] "
        # Prompt (with 'job' info):
#        PS1=${PS1}"\[\$(job_color)\]>\[${NC}\] "
        # Set title of current xterm:
#        PS1=${PS1}"\[\e]0;[\u@\h] \w\a\]"

        ;;
    *)
#        PS1="(\A \u@\h \W) > " # --> PS1="(\A \u@\h \w) > "
                               # --> Shows full pathname of current dir.
        ;;
esac


# Following the trend od the original bashrc
#PS2='> '
#PS3='> '
#PS4='+ '



export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"
export HISTTIMEFORMAT="$(echo -e ${BCyan})[%d/%m %H:%M:%S]$(echo -e ${NC}) "
export HISTCONTROL=ignoredups
export HOSTFILE=$HOME/.hosts    # Put a list of remote hosts in ~/.hosts



#============================================================
#
#  ALIASES AND FUNCTIONS
#
#  Arguably, some functions defined here are quite big.
#  If you want to make this file smaller, these functions can
#+ be converted into scripts and removed from here.
#
#============================================================

#-------------------
# Personnal Aliases
#-------------------

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias gtypist='gtypist -b'

function cd_
{
  #[[ -d "$@" ]] || return 1
  cd "$@"
  echo $(pwd) > ~/.last_dir
}

# Renamed cd to cd and export the directory path we are entering
alias cd='cd_'

# accidental deletion
alias rm='rm -I'

## Update: moved this part to .myscr/vim so that scripts (like ranger) could access it
## For this to work, $HOME/.myscr has to be in the first part of the $PATH variable
## Big decision: run vim in servermode always
## This way, I can source new vimrc automatically
## Will it get slow if I run too many instances?
##alias vim='vim --servername VIM'
## Note that the default servername is VIM
## Running this command many times creates servers like VIM1, VIM2,...
## Running `vim --servername this --servername that` runs only THAT
## So, we can connect to preciously connected servers
## And, it does not interfere with my vtex .myscript either!
## Weird win-win situation

# Optional alias
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# Sort by size, biggest last, add the contents of each directory
alias ls_size='du -sch .[!.]* * | sort -h'

## countdown and stopwatch for terminal

function countdown(){
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ge `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}
function stopwatch(){
  date1=`date +%s`; 
   while true; do 
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
    sleep 0.1
   done
}

## Making sxiv capable of opening .gifs
## Decided not to use it
#alias sxiv='sxiv -a'

## For colour output in cat
#
#alias ccat='vimcat'
#
## Added by me for a custom lock screen comand
#
#alias lscr='cmatrix -a -b -u 5; vlock -a'
#
## A quick shortcut to my favourite working directory
#
#alias Lenovo='cd /storage/Lenovo/'

# An alias needed by .myscr called dwz to change to the tempo directory after extracting the latest zip file

alias dwz='gtstf && cd ~/tempo'

alias dwn='. ctstf'

alias comp='g++ `pkg-config opencv --cflags --libs`'
# An experimental directory changing attempt from the last opened path
# ldp to load the path from the file .last_dir which was created by the modified "cd" alias. See the function cd_ for details.
alias ldp='cd $(cat ~/.last_dir)'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


#-------------------------------------------------------------
# Spelling typos - highly personnal and keyboard-dependent :-)
#-------------------------------------------------------------

#alias xs='cd'
#alias vf='cd'
#alias moer='more'
#alias moew='more'
#alias kk='ll'




#-------------------------------------------------------------
# File & strings related functions:
#-------------------------------------------------------------


# Find a file with a pattern in name:
#function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
#function fe() { find . -type f -iname '*'"${1:-}"'*' \
#-exec ${2:-file} {} \;  ; }


# Nice examples of functions

function swap()
{ # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}


# Makes your life easy

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

# Redefinig sdcv as define to utilise dictionary
function define() { sdcv "$1"; }
#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------


function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }


function killps()   # kill by process name
{
    local pid pname sig="-TERM"   # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
    do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
    for fs ; do

        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}


function my_ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / /home
#    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
#    echo -e "\n${BRed}Local IP Address :$NC" ; ip addr
#    echo -e "\n${BRed}Open connections :$NC "; netstat-nat -pan --inet;
    echo
}

#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------

function repeat()       # Repeat n times command.
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}


function ask()          # See 'killps' for example of use.
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

function corename()   # Get name of app that created a corefile.
{
    for file ; do
        echo -n $file : ; gdb --core=$file --batch | head -1
    done
}



#######################################################################
#                     Adding path for my scripts                      #
#######################################################################
# Moving this to .xsessionrc so that awesome can access this path (as
# opposed to .bash_profile, which does not work)
#export PATH=$PATH:~/.myscr/


#Creating a config file for linux calculator bc, which does not support a config file by default
# we will add scale=5 in this file to make it support decimal divisions
export BC_ENV_ARGS=~/.bcrc


#######################################################################
#           setting the editor for ranger to use clipboard            #
#######################################################################
VISUAL=vim; export VISUAL EDITOR=vim; export EDITOR

# Use bash-completion, if available
# The package bash-completion is needed
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

#export GOPATH=$HOME/gopath
#export PATH=$GOPATH:$GOPATH/bin:$PATH

# For the wacom stylus that does not work from xrog.conf
# Also, copy the file wacom.config in X11/xorg.conf.d/ which basically says
#  Option "PressCurve" "0,10,90,100"
# the Threshold option does not work from that file so it has to be in bashrc
#xsetwacom --set "Wacom HID 50EE Pen stylus" Threshold "500"

# For Wacom stylus 
# Left out option: xsetwacom "RawSample" 4, which is default anyway
## turning off for wacom one
xinput --set-prop "Wacom HID 50EE Pen stylus" "Wacom Pressurecurve" 0 10 90 100
xinput --set-prop "Wacom HID 50EE Pen stylus" "Wacom Pressure Threshold" 500
# Workaround for the bug
#xinput --set-prop "Wacom HID 50EE Pen stylus" "Wacom Hover Click" 0

##################################
## env variables for UH-anita
#
## so that root is detectable
## this updates the env variable LD_LIBRARY_PATH
### use per needed basis, as it is messing up my ldp script
### this sh file must be calling a cd command every time 
#alias thisroot='. /home/debdeeproot/bin/thisroot.sh'
## to include the header files while compiling the cpp files
#export CPATH=/home/debdeep/root/include/
#export ANITA_UTIL_INSTALL_DIR=/home/debdeep/anitaUtil
#export ANITA_UTIL_INC_DIR=/home/debdeep/anitaUtil/include
# then you run your cpp files with: g++ filename `root-config --libs`
export LD_LIBRARY_PATH=$HOME/libWTools/lib


#################################
#xrdb ~/.Xresources

### Trello secrets for 3llo
### we install locally using: gem install --user-install 3llo
#export PATH=$PATH:~/.gem/ruby/2.5.0/bin
### Add the user, key and token to a file called .3llo and source it
#source .3llo
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$PATH:$HOME/gems/bin"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#######################################################################
#            Disabling Touchpad Forever for stealing mouse            #
#######################################################################
#xinput disable "Wacom HID 50EE Finger"
xinput disable "Wacom HID 50EE Finger touch"


# For matlab curl usage
#export DYLD_LIBRARY_PATH="/usr/bin"
export BROWSER=/usr/bin/firefox
