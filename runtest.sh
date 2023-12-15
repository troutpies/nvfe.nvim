#!/bin/bash
#
script="testscript.lua"
nvim="/usr/local/bin/nvim"
editcmd="nvim -c \"source %\" ${script}"
echo "$editcmd"

zellij run -f -- "${editcmd}"
