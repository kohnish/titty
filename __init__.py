import sys
import os
sys.path.append(os.path.dirname(os.path.realpath(__file__)))

def titty_main():
    from kitty.entry_points import main
    main()
