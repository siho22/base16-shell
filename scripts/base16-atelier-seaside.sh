#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Atelier Seaside scheme by Bram de Haan (http://atelierbramdehaan.nl)

base00="13/15/13"
base01="24/29/24"
base02="5e/6e/5e"
base03="68/7d/68"
base04="80/99/80"
base05="8c/a6/8c"
base06="cf/e8/cf"
base07="f4/fb/f4"
base08="e6/19/3c"
base09="87/71/1d"
base0A="98/98/1b"
base0B="29/a3/29"
base0C="19/99/b3"
base0D="3d/62/f5"
base0E="ad/2b/ee"
base0F="e6/19/c3"

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
put_template 233 $base00
put_template 235 $base01
put_template 242 $base02
put_template 65 $base03
put_template 72 $base04
put_template 108 $base05
put_template 194 $base06
put_template 231 $base07
put_template 197 $base08
put_template 94 $base09
put_template 100 $base0A
put_template 34 $base0B
put_template 38 $base0C
put_template 27 $base0D
put_template 129 $base0E
put_template 163 $base0F

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg 8ca68c # foreground
  put_template_custom Ph 131513 # background
  put_template_custom Pi 8ca68c # bold color
  put_template_custom Pj 5e6e5e # selection color
  put_template_custom Pk 8ca68c # selected text color
  put_template_custom Pl 8ca68c # cursor
  put_template_custom Pm 131513 # cursor text
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
