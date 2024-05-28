# nnn config

alias nnn="nnn -P p"

export NNN_OPTS="AaHed"

export NNN_PLUG='p:preview-tui;i:iconlookup'

export NNN_OPENER="$HOME"/.config/nnn/plugins/nuke

export LESS="-~ -S"

BLK="0d" 
CHR="0d" 
DIR="0d" 
EXE="0a" 
REG="08" 
HARDLINK="03" 
SYMLINK="0e" 
MISSING="08"
ORPHAN="09" 
FIFO="0F" 
SOCK="0F" 
OTHER="01"

export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
