#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Spacemacs scheme by Nasser Alshammari (https://github.com/nashamri/spacemacs-theme)

base00="1f/20/22"
base01="28/28/28"
base02="44/41/55"
base03="58/58/58"
base04="b8/b8/b8"
base05="a3/a3/a3"
base06="e8/e8/e8"
base07="f8/f8/f8"
base08="f2/24/1f"
base09="ff/a5/00"
base0A="b1/95/1d"
base0B="67/b1/1d"
base0C="2d/95/74"
base0D="4f/97/d7"
base0E="a3/1d/b1"
base0F="b0/30/60"

color_foreground=$base05
color_background=$base00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $base00 # Black
put_template 1  $base08 # Red
put_template 2  $base0B # Green
put_template 3  $base0A # Yellow
put_template 4  $base0D # Blue
put_template 5  $base0E # Magenta
put_template 6  $base0C # Cyan
put_template 7  $base05 # White
put_template 8  $base03 # Bright Black
put_template 9  $base08 # Bright Red
put_template 10 $base0B # Bright Green
put_template 11 $base0A # Bright Yellow
put_template 12 $base0D # Bright Blue
put_template 13 $base0E # Bright Magenta
put_template 14 $base0C # Bright Cyan
put_template 15 $base07 # Bright White

# 256 color space
put_template 234 $base00
put_template 235 $base01
put_template 238 $base02
put_template 240 $base03
put_template 250 $base04
put_template 248 $base05
put_template 254 $base06
put_template 231 $base07
put_template 196 $base08
put_template 214 $base09
put_template 136 $base0A
put_template 70 $base0B
put_template 29 $base0C
put_template 33 $base0D
put_template 127 $base0E
put_template 125 $base0F

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg a3a3a3 # foreground
  put_template_custom Ph 1f2022 # background
  put_template_custom Pi a3a3a3 # bold color
  put_template_custom Pj 444155 # selection color
  put_template_custom Pk a3a3a3 # selected text color
  put_template_custom Pl a3a3a3 # cursor
  put_template_custom Pm 1f2022 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset base00
unset base01
unset base02
unset base03
unset base04
unset base05
unset base06
unset base07
unset base08
unset base09
unset base0A
unset base0B
unset base0C
unset base0D
unset base0E
unset base0F
unset color_foreground
unset color_background
