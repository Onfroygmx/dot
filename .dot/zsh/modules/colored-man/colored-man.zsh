#!/usr/bin/env zsh
#!/bin/zsh

export LESS_TERMCAP_mb=$'\e[05;31m'      # begin blinking mode -
export LESS_TERMCAP_md=$'\e[01;34m'      # begin bold - Blue
export LESS_TERMCAP_us=$'\e[04;32m'      # begin underline - Green
export LESS_TERMCAP_so=$'\e[01;33;41m'   # begin standout-mode - foreground Yellow backgtound Red
export LESS_TERMCAP_ue=$'\e[m'           # leave underline mode (us)
export LESS_TERMCAP_se=$'\e[m'           # leave standout-mode (so)
export LESS_TERMCAP_me=$'\e[m'           # turn off all appearance modes (mb, md, so, us)
