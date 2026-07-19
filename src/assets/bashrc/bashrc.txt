#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Utilities
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias files='ls -p | grep -v /'
alias folders='ls -d */'
alias hfolders='ls -d .*/ */'
alias search='grep -rwl'

# Package management
alias up='sudo pacman -Syyu --noconfirm && sudo rm -rf /var/cache/pacman/pkg/* && yes | sudo pacman -Scc && sync && sudo pacman -Rns $(pacman -Qdtq)'
alias clean='yes | sudo pacman -Scc'
alias autoremove='sudo pacman -Rns $(pacman -Qdtq)'

# Power Management
alias performance='sudo cpupower frequency-set -g performance'
alias powersave='sudo cpupower frequency-set -g powersave'
alias schedutil='sudo cpupower frequency-set -g schedutil'
alias governor='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias lol='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors'

# Docker Management
alias restart_containers='docker restart $(docker ps -a -q)'
alias stop_containers='docker stop $(docker ps -a -q)'

# Shell Prompt
PS1='[\u@\h \W]\$ '
fastfetch
