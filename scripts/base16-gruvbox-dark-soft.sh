#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Gruvbox dark, soft scheme by Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)

base00="32/30/2f"
base01="3c/38/36"
base02="50/49/45"
base03="66/5c/54"
base04="bd/ae/93"
base05="d5/c4/a1"
base06="eb/db/b2"
base07="fb/f1/c7"
base08="fb/49/34"
base09="fe/80/19"
base0A="fa/bd/2f"
base0B="b8/bb/26"
base0C="8e/c0/7c"
base0D="83/a5/98"
base0E="d3/86/9b"
base0F="d6/5d/0e"

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
put_template 236 $base00
put_template 237 $base01
put_template 239 $base02
put_template 59 $base03
put_template 144 $base04
put_template 180 $base05
put_template 187 $base06
put_template 230 $base07
put_template 196 $base08
put_template 208 $base09
put_template 214 $base0A
put_template 142 $base0B
put_template 107 $base0C
put_template 109 $base0D
put_template 175 $base0E
put_template 166 $base0F

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg d5c4a1 # foreground
  put_template_custom Ph 32302f # background
  put_template_custom Pi d5c4a1 # bold color
  put_template_custom Pj 504945 # selection color
  put_template_custom Pk d5c4a1 # selected text color
  put_template_custom Pl d5c4a1 # cursor
  put_template_custom Pm 32302f # cursor text
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
