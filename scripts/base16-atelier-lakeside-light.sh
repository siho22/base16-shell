#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Atelier Lakeside Light scheme by Bram de Haan (http://atelierbramdehaan.nl)

base00="eb/f8/ff"
base01="c1/e4/f6"
base02="7e/a2/b4"
base03="71/95/a8"
base04="5a/7b/8c"
base05="51/6d/7b"
base06="1f/29/2e"
base07="16/1b/1d"
base08="d2/2d/72"
base09="93/5c/25"
base0A="8a/8a/0f"
base0B="56/8c/3b"
base0C="2d/8f/6f"
base0D="25/7f/ad"
base0E="6b/6b/b8"
base0F="b7/2d/d2"

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
put_template 255 $base00
put_template 153 $base01
put_template 74 $base02
put_template 67 $base03
put_template 66 $base04
put_template 24 $base05
put_template 235 $base06
put_template 234 $base07
put_template 161 $base08
put_template 130 $base09
put_template 100 $base0A
put_template 64 $base0B
put_template 29 $base0C
put_template 31 $base0D
put_template 61 $base0E
put_template 128 $base0F

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg 516d7b # foreground
  put_template_custom Ph ebf8ff # background
  put_template_custom Pi 516d7b # bold color
  put_template_custom Pj 7ea2b4 # selection color
  put_template_custom Pk 516d7b # selected text color
  put_template_custom Pl 516d7b # cursor
  put_template_custom Pm ebf8ff # cursor text
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
