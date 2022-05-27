#!/usr/bin/env python3
# License: GPL v3 Copyright: 2015, Kovid Goyal <kovid at kovidgoyal.net>


def titty_main():
    from . import titty
    titty.titty_main()


if __name__ == '__main__':
    from kitty.entry_points import main
    main()
