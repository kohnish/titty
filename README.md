Titty - Terminal emulator with basic tmux features based on kitty, not titties.

Additional features:
- Fix ansi escape for scroll back
- Fix pager not working on scroll
- Fix security vulnerabilities (Ignoring OS SSL certificate)
- Fix next tab (prev tab is still broken)
- Fix build scripts for linux wayland with pip and cmake
- Add repeat key support (hard coded for hjkl for now)
- Try to rotate on Move window right (best effort)

ToDo:
- Remove spying feature connecting to the internet by default (For now suppress by update_check_interval 0 manually in the config)
- Support repeat key properly
- Implement proper ctrl + o for swapping panes
- Remove python dependencies
- Migrate to yaml config
- Refactor build scripts and add titty binary
- Fix prev next not working
- Remove ssh feature
- Remove kitty terminfo
- Remove layout features
- Maybe directly support tmux config
- Make an initial release
- Drop dbus dependency

Example config that mimics tmux behaviour:
```
# General
term                    xterm-256color
cursor_shape            block
shell_integration       disabled
disable_ligatures       always
tab_bar_min_tabs        0
font_family             Inconsolata-SemiBold
bold_font               Inconsolata-Bold
italic_font             auto
bold_italic_font        auto
font_size               14
copy_on_select          yes
background_opacity      0.9
remember_window_size    no
tab_bar_style           slant
linux_display_server    wayland
update_check_interval   0
enabled_layouts         splits:split_axis=horizontal
scrollback_pager        sh -c "cat | sed -e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba' -e 's/[[:space:]]*$//' | vim -c 'set filetype=log noswapfile nobackup noundofile nospell cmdheight=1 nolist nocursorline nowrap noshowmode noruler laststatus=0 noshowcmd nonumber | hi Normal guibg=NONE ctermbg=NONE | hi EndOfBuffer guibg=NONE ctermbg=NONE | nnoremap <CR> :quit!<CR> | nnoremap <C-c> :quit!<CR>' + -R -n -"
window_border_width     2

# Keybind
map shift+insert        paste_from_clipboard
map ctrl+k>[            show_scrollback
map ctrl+k>c            new_tab
map ctrl+k>%            launch --location=vsplit --cwd=current
map ctrl+k>"            launch --location=hsplit --cwd=current
map ctrl+k>n            next_tab
map ctrl+k>x            close_window
map ctrl+k>r            clear_terminal reset active
map ctrl+k>left         neighboring_window left
map ctrl+k>right        neighboring_window right
map ctrl+k>up           neighboring_window up
map ctrl+k>down         neighboring_window down
map ctrl+k>l            resize_window narrower 10
map ctrl+k>h            resize_window wider 10
map ctrl+k>k            resize_window taller 10
map ctrl+k>j            resize_window shorter 10
map ctrl+k>o            move_window right
map ctrl+k>0            goto_tab 1
map ctrl+k>1            goto_tab 2
map ctrl+k>2            goto_tab 3
map ctrl+k>3            goto_tab 4
map ctrl+k>4            goto_tab 5
map ctrl+k>5            goto_tab 6
map ctrl+k>6            goto_tab 7
map ctrl+k>7            goto_tab 8
map ctrl+k>8            goto_tab 9
map ctrl+k>9            goto_tab 10
#repeat_map              h
#repeat_map              k
#repeat_map              j
#repeat_map              l

# Theme
foreground              #ffffff
background              #000000
cursor                  #0a9dff
active_tab_foreground   #ffffff
active_tab_background   #0a9dff
cursor_text_color       #ffffff
color0                  #000000
color1                  #ff2c4b
color2                  #8bbe00
color3                  #eeb340
color4                  #0a9dff
color5                  #ff5990
color6                  #66cdaa
color7                  #d9cec3
color8                  #998f84
color9                  #df0021
color10                 #aeee00
color11                 #f4cf86
color12                 #26a8ff
color13                 #ff87af
color14                 #6cbfa3
color15                 #ffffff
active_border_color     #0a9dff
inactive_border_color   #ffffff
bell_border_color       #aeee00
```

Development (only for linux wayland atm):
```
git clone git@github.com:kohnish/titty.git
cd titty
mkdir cmake-build-linux
cd cmake-build-linux
cmake ..
make run -j8
```
