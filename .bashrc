# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=500000
HISTTIMEFORMAT="%d/%m/%y %T "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
alias d='date +%Y%m%d%H%M%S'
alias nvidia-mon=' nvidia-smi dmon -s pumt -i 6'

#
# Modules environment needs to be aware of architecture
#
# Arch          Partition:        Nodes:        Description:
# amd64:        defq              n001-n003     ( DP AMD EPYC 7601 32-Core Processor SMT2 128 threads w/1 qty Vega20 GPU)
# amd64:        defq              n004          ( DP AMD EPYC 7601 32-Core Processor SMT2 128 threads w/1 qty Mi100/32GB GPU)
# aarch64:      armq,aarchq       n005-n008     ( DP Cavium ThunderX2 CN9980 SMT4 256 threads )
# aarch64:      huaq,aarchq,a40q  n009-n012     ( DP Huawei Kunpeng920-6426 no-HT 128 cores, 1 qty Nvidia A40/48GB and 1 qty Brainchip AKD1000 coprocessor)
# amd64:        a100q             n013-n014     ( DP AMD EPYC 7763 64-Core Processor SMT2 256 threads w/2 A100/40GB GPUs)
# amd64:        mi100q            n015-n016     ( DP AMD EPYC 7763 64-Core Processor SMT2 256 threads w/2 Mi100/32GB GPUs)
# amd64:        fpgaq             n017-n020     ( DP AMD EPYC 7413 24-Core Processor SMT2 96 threads w/Xilinx UA250 and UA280)
# amd64:        rome16q           n049-n060     ( DP AMD EPYC 7302P 16-Core Processor SMT2 32 threads )
# amd64:        slowq             n041-n048     ( SP Intel(R) Xeon(R) Silver 4112 CPU @ 2.60GHz 8core )
# x64_64:       xeon16q           slr-adm1, srl-adm2, srl-mds1, srl-mds2  (Intel Xeon Gold 6140)
# x64_64:       xeon16q           srl-login1    ( DP Intel Xeon Gold 6140, 1 qty Nvidia Tesla T4 )
# x64_64/V100:  dgx2q             g001          ( DP Intel Xeon Scalable Platinum 8176 and 16 qty Nvidia Volta V100/32GB )
# x64_64/V100:  hggx2q            g002          ( DP AMD EPYC 7763 64-Core Processor SMT2 256 thread and 8 qty Nvidia Volta A100/80GB )
# x64_64/HL205: habanaq           h001          ( DP Intel Xeon Scalable Platinum 8360Y and 8 qty Habana Gaudi HL205/32GB )
# x64_64/GC200: ipuq              srl-login2    ( DP Intel Xeon Scalable Platinum 8168 and 64 qty Graphcore IPUs GC-200 (Mk2) )
# x64_64/k40x   NA                srl-login3    ( TBA )
# x64_64:       virtq             v001-v004     ( DP nodes for running VMs at close to line rate )

if [ "`uname -m`" = "x86_64" ];
  then
  if shopt -q login_shell; then
    echo "You are on an x86_64 node (Epyc or Xeon)"
    module purge
    module load slurm/21.08.8
    module use /cm/shared/ex3-qc-modules/modulefiles      # Quantum Computing software
    module use /cm/shared/ex3-modules/latest/modulefiles
    module load google/gdrive/2.1.0
    module load numactl/gcc/2.0.18
    module load hwloc/gcc/2.10.0
    module load docker/20.10.26

    if [ "`uname -n`" = "g001" ];
    then
        module load cuda12.2/toolkit/12.2.2
        module load cuda12.2/blas/12.2.2
	module load cuda12.2/fft/12.2.2
        module load cuda12.2/profiler/12.2.2
        module load cuda12.2/nsight/12.2.2
    fi
    if [ "`uname -n`" = "g002" ];
    then
        module load cuda12.2/toolkit/12.2.2
        module load cuda12.2/blas/12.2.2
        module load cuda12.2/fft/12.2.2
        module load cuda12.2/profiler/12.2.2
        module load cuda12.2/nsight/12.2.2
    fi

    if [ "`uname -n`" = "ipu-pod64-server1" ];
    then
    	    # Old  Poplar SDK versions 1.0.142, 1.2.0, 1.3.0 and 1.4.0, 2.0.0, 2.1.0
#            module load graphcore/vipu/1.12.5           # For accessing new M2000 GC-200 nodes.
#            module load graphcore/vipu/1.12.6           # For accessing new M2000 GC-200 nodes.
#            module load graphcore/vipu/1.14.0           # For accessing new M2000 GC-200 nodes.
#            module load graphcore/vipu/1.14.3           # For accessing new M2000 GC-200 nodes.
#            module load graphcore/vipu/1.15.1           # For accessing new M2000 GC-200 nodes.
#           module load graphcore/vipu/1.15.2           # For accessing new M2000 GC-200 nodes.
#            module load graphcore/vipu/1.16.0           # For accessing new M2000 GC-200 nodes.
           # module load graphcore/vipu/1.16.1           # For accessing new M2000 GC-200 nodes.
#            module load graphcore/vipu/1.17.0           # For accessing new M2000 GC-200 nodes.
            module load graphcore/vipu/1.18.0           # For accessing new M2000 GC-200 nodes.
#	    module load graphcore/gc/1.3.0              # From SDK 1.4.0 GC cmds included in SDK
#	    module load graphcore/sdk/1.3.0
#           module load graphcore/sdk/1.4.0             # gc included in sdk as of 1.3.0
#            module load graphcore/sdk/2.0.0             # gc included in sdk as of 2.0.0
#            module load graphcore/sdk/2.1.0             # gc included in sdk as of 2.1.0
#            module load graphcore/sdk/2.2.0             # gc included in sdk as of 2.2.0
#            module load graphcore/sdk/2.3.0             # gc included in sdk as of 2.3.0
#            module load graphcore/sdk/2.4.0             # gc included in sdk as of 2.4.0
#            module load graphcore/sdk/2.5.1             # gc included in sdk as of 2.5.1
#            module load graphcore/sdk/2.6.0             # gc included in sdk as of 2.6.0
#            module load graphcore/sdk/3.0.0             # gc included in sdk as of 3.0.0
            module load graphcore/sdk/3.4.0             # gc included in sdk as of 3.4.0
#	    module load graphcore/tf/1.4.0_tf1.15.4     # Tensorflow v.1.5.4
#	    module load graphcore/tf/1.4.0_tf2.1.2      # Tensorflow v.2.1.2
#	    module load graphcore/tf/2.0.0_tf1.15.4     # Tensorflow v.1.5.4
#           module load graphcore/tf/2.0.0_tf2.1.2      # Tensorflow v.2.1.2
#	    module load graphcore/tf/2.1.0_tf1.15.4     # Tensorflow v.1.5.4
#	    module load graphcore/tf/2.1.0_tf2.1.2      # Tensorflow v.2.1.2
#	    module load graphcore/tf/2.2.0_tf1.15.4     # Tensorflow v.1.5.4
#	    module load graphcore/tf/2.3.0_tf1.15.5     # Tensorflow v.1.5.5
#	    module load graphcore/tf/2.2.0_tf2.4.1      # Tensorflow v.2.4.1
#	    module load graphcore/tf/2.3.0_tf2.4.3      # Tensorflow v.2.4.3
#           module load graphcore/tf/2.4.0_tf1.15.5     # Tensorflow v.1.15.5
#	    module load graphcore/tf/2.4.0_tf2.4.4      # Tensorflow v.2.4.4
#           module load graphcore/tf/2.5.1_tf1.15.5     # Tensorflow v.1.15.5
#	    module load graphcore/tf/2.5.1_tf2.5.2      # Tensorflow v.2.4.4
#           module load graphcore/tf/3.0.0_tf1.15.5     # Tensorflow v.1.15.5
#	    module load graphcore/tf/3.0.0_tf2.6.3      # Tensorflow v.2.6.3
    fi
  fi
elif [ "`uname -m`" = "aarch64" ];
    then
	if shopt -q login_shell; then
          echo "You are on an Aarch64 node"
	  module purge
	  module load slurm/21.08.8
	  module load google/gdrive/2.1.0
          module load numactl/gcc/2.0.18
          module load hwloc/gcc/2.10.0
	  module use /cm/shared/ex3-modules/latest/modulefiles
	  module load docker/20.10.26
        fi
fi

umask 0002
# umask 0022    rw user, r group, r world
# umask 0026    rw user, r group, world none

# export PATH="$HOME/miniconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/victoria/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/victoria/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/victoria/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/victoria/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export CUDA_HOME=/cm/shared/apps/cuda12.2/toolkit/12.2.2
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
export ESPEAK_PATH=$(which espeak)
export ESPEAK_PATH=$(which espeak)
export ESPEAK_PATH=$(which espeak)
