import os

c = get_config()
if os.environ.get("DOTFILES_VIM_MODE") == "1":
    c.TerminalInteractiveShell.editing_mode = "vi"
    c.TerminalInteractiveShell.timeoutlen = 0.05
