----------------------------------------------------------------
-- Plugins
----------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({

  -- Editing
  { "dbakker/vim-paragraph-motion" },
  { "xiyaowong/nvim-cursorword" },
  { "nelstrom/vim-visual-star-search" },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },

  -- Tools
  { "junegunn/fzf", build = ":call fzf#install()" },
  { "tpope/vim-eunuch" },
  { "vim-scripts/loremipsum" },

  -- Visual
  { "ap/vim-css-color" },
  { "lewis6991/gitsigns.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "w0ng/vim-hybrid", lazy = false },

  -- Intel
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/vim-vsnip" },

})

----------------------------------------------------------------
-- Binaries
----------------------------------------------------------------

local function ensure_binary(binary, command)
  if vim.fn.executable(binary) == 0 then
    vim.notify("Installing " .. binary, vim.log.levels.INFO)
    vim.fn.jobstart(command, {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          local message = "Installed " .. binary .. ". Please restart Neovim."
          vim.notify(message, vim.log.levels.INFO)
        else
          local message = "Failed to install " .. binary .. ". Check :messages for details."
          vim.notify(message, vim.log.levels.ERROR)
        end
      end,
    })
  end
end

ensure_binary("ruff", { "uv", "tool", "install", "-U", "ruff" })
ensure_binary("pyright-langserver", { "uv", "tool", "install", "-U", "pyright" })

----------------------------------------------------------------
-- Helpers
----------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })
local function autocmd(events, pattern, action)
  local opts = { group = augroup, pattern = pattern }
  if type(action) == "string" then
    opts.command = action
  else
    opts.callback = action
  end
  vim.api.nvim_create_autocmd(events, opts)
end

----------------------------------------------------------------
-- Visual
----------------------------------------------------------------

vim.opt.termguicolors = false
vim.opt.background = "dark"
vim.g.hybrid_custom_term_colors = 1

vim.cmd("colorscheme hybrid")

local hi = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

hi("Normal",             { ctermfg = "White" })
hi("LineNr",             { ctermfg = "DarkGray" })
hi("Visual",             { ctermbg = "DarkGray" })
hi("CursorLineNr",       { ctermfg = "LightGray", ctermbg = "Black" })
hi("SignColumn",         { ctermbg = nil })
hi("MatchParen",         { ctermfg = "Black",     ctermbg = "LightBlue" })
hi("TabLine",            { ctermfg = "LightGray", ctermbg = "Black", cterm = {} })
hi("TabLineFill",        { ctermbg = "Black",     cterm = {} })
hi("TabLineSel",         { ctermfg = "Black",     ctermbg = "LightGray" })
hi("ErrorMsg",           { ctermfg = "Red",       ctermbg = nil })
hi("SpellBad",           { ctermfg = "Black",     ctermbg = "Red" })
hi("DiffAdd",            { ctermbg = "Green" })
hi("DiffChange",         { ctermbg = "Blue" })
hi("DiffDelete",         { ctermbg = "Red" })
hi("NormalFloat",        { ctermbg = "Black", ctermfg = "White" })
hi("FloatBorder",        { ctermbg = "Black", ctermfg = "DarkGray" })
hi("IndentColor",        { ctermfg = "DarkGray",  ctermbg = nil })
hi("CursorWord",         { ctermbg = "DarkGray",  underline = false })

----------------------------------------------------------------
-- Plugin settings
----------------------------------------------------------------

-- junegunn/fzf
local fzfcmd = "rg --files --no-messages --hidden -g '!{.git,.venv,node_modules,pycache}'"
local vim_fzfcmd = fzfcmd:gsub("'", "''")
vim.keymap.set("n", "<C-P>", function()
    vim.cmd(string.format([[call fzf#run(fzf#wrap({'source': '%s'}))]], vim_fzfcmd))
end, { silent = true })
vim.g.fzf_history_dir = "/tmp/fzf_history"
vim.g.fzf_layout = { down = "40%" }
vim.g.fzf_action = {
    ["return"]  = "drop",
    ["ctrl-t"]  = "tab drop",
    ["ctrl-x"]  = "split",
    ["ctrl-v"]  = "vsplit",
}

-- hrsh7th/vim-vsnip
vim.cmd([[imap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Tab>']])

-- lukas-reineke/indent-blankline.nvim
require("ibl").setup({
  indent = { highlight = "IndentColor", char = "│" },
  scope = { enabled = false },
})

-- lewis6991/gitsigns.nvim
require("gitsigns").setup({
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
})

-- hrsh7th/nvim-cmp
local cmp = require("cmp")
cmp.setup({
  window = {
    completion = { winhighlight = "Normal:Pmenu" },
    documentation = { winhighlight = "Normal:Pmenu" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"]     = cmp.mapping.select_next_item(),
    ["<C-k>"]     = cmp.mapping.select_prev_item(),
    ["<C-d>"]     = cmp.mapping.scroll_docs(4),
    ["<C-u>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"]      = cmp.mapping.confirm({ select = false }),
    ["<C-e>"]     = cmp.mapping.abort(),
  }),
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

-- windwp/nvim-autopairs
local autopairs = require("nvim-autopairs.completion.cmp")
require("cmp").event:on("confirm_done", autopairs.on_confirm_done())

----------------------------------------------------------------
-- LSP
----------------------------------------------------------------

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local root_markers = { "pyproject.toml", "ruff.toml", "setup.py", ".git" }

vim.lsp.config("ruff", {
  capabilities = capabilities,
  root_markers = root_markers,
  filetypes = { "python" },
  cmd = { "ruff", "server" },
})

vim.lsp.config("pyright", {
  capabilities = capabilities,
  root_markers = root_markers,
  filetypes = { "python" },
  cmd = { "pyright-langserver", "--stdio" },
  settings = {
    python = {
      venvPath = ".",
      venv = ".venv",
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "standard",
        diagnosticMode = "openFilesOnly",
      }
    }
  }
})

vim.lsp.enable("ruff")
vim.lsp.enable("pyright")

autocmd("BufWritePre", "*.py", function()
  vim.lsp.buf.format({ name = "ruff" })
end)

vim.api.nvim_create_user_command("LspClients", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("No LSP clients attached to this buffer.", vim.log.levels.WARN)
    return
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  vim.notify("Attached LSP clients: " .. table.concat(names, ", "), vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd("tab drop " .. vim.lsp.get_log_path())
end, {})

----------------------------------------------------------------
-- Status Line
----------------------------------------------------------------

vim.opt.statusline = table.concat({
  "%#DiffAdd#%{(mode()=='n')?'\\ \\ NORMAL\\ ':''}",
  "%#DiffDelete#%{(mode()=='i')?'\\ \\ INSERT\\ ':''}",
  "%#DiffDelete#%{(mode()=='r')?'\\ \\ RPLACE\\ ':''}",
  "%#DiffChange#%{(mode()=='v')?'\\ \\ VISUAL\\ ':''}",
  "%#Cursor#",
  " %n ",
  "%#Visual#",
  "%{&paste?'\\ PASTE\\ ':''}",
  "%{&spell?'\\ SPELL\\ ':''}",
  "%#CursorIM#",
  "%R%M",
  "%#Cursor#%#CursorLine#",
  " %t ",
  "%=",
  "%#CursorLine# %Y ",
  "%#CursorIM# %3l:%-2c ",
  "%#Cursor# %3p%% ",
})

autocmd("CursorMoved", "*", function()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diags = vim.diagnostic.get(0, { lnum = lnum })
  table.sort(diags, function(a, b) return a.severity < b.severity end)
  local msg = #diags > 0 and diags[1].message:gsub("\n", " ") or ""
  if vim.fn.strdisplaywidth(msg) > vim.v.echospace then
    msg = vim.fn.strcharpart(msg, 0, vim.v.echospace - 3) .. "..."
  end
  vim.cmd("redraw")
  vim.api.nvim_echo({{ msg, "ErrorMsg" }}, false, {})
end)

----------------------------------------------------------------
-- Settings
----------------------------------------------------------------

vim.opt.lazyredraw    = true
vim.opt.ignorecase    = true
vim.opt.smartcase     = true
vim.opt.foldenable    = false
vim.opt.viminfo       = vim.o.viminfo .. ",%"
vim.opt.completeopt:remove("preview")
vim.opt.scrolloff     = 100
vim.opt.splitbelow    = true
vim.opt.splitright    = true
vim.opt.timeoutlen    = 300
vim.opt.ttimeoutlen   = 0
vim.opt.visualbell    = true
vim.opt.history       = 250
vim.opt.wildmode      = "longest,list"
vim.opt.expandtab     = true
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:remove("o")
vim.opt.joinspaces    = false
vim.opt.tabstop       = 2
vim.opt.shiftwidth    = 2
vim.opt.softtabstop   = 2
vim.opt.cursorline    = true
vim.opt.number        = true
vim.opt.mouse         = "a"
vim.opt.undofile      = true
vim.opt.modeline      = true
vim.opt.shortmess     = "lxWAIF"
vim.opt.updatetime    = 200
vim.opt.laststatus    = 1
vim.opt.breakindent   = true
vim.opt.inccommand    = ""
vim.opt.conceallevel  = 0

if vim.fn.has("mac") == 1 then
  vim.opt.clipboard = "unnamed"
else
  vim.opt.clipboard = "unnamedplus"
end

----------------------------------------------------------------
-- Autocommands
----------------------------------------------------------------

autocmd({ "BufRead", "BufNewFile" }, "*", [[match Error /\s\+$/]])
autocmd({ "FocusGained", "BufEnter" }, "*", "checktime")
-- autocmd("BufWritePost", "*", function() require("lint").try_lint() end)
autocmd("VimLeave", "*", function() vim.fn.system("tmux setw automatic-rename") end)

autocmd("BufWritePre", "*", function()
  if vim.bo.filetype ~= "snippets" then vim.cmd([[%s/\s\+$//e]]) end
end)

autocmd("BufReadPost", "*", function()
  local mark = vim.api.nvim_buf_get_mark(0, '"')
  if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
    pcall(vim.api.nvim_win_set_cursor, 0, mark)
  end
end)

autocmd({ "BufReadPost", "FileReadPost", "BufNewFile", "BufEnter" }, "*", function()
  vim.fn.system("tmux rename-window '" .. vim.fn.expand("%:t") .. "'")
end)

local function python_syntax()
  vim.cmd([[
    syntax keyword MyPythonConstants True False None Ellipsis
    syntax match MyPythonSelf "\<self\>\.\?"
    syntax match MyPythonLibrary "\<\(np\|jnp\|os\|nn\|nj\|re\)\."
    syntax match MyPythonKwarg "\((\| \)\@<=\<[A-Za-z0-9_]\+\>="
    syntax match MyPythonNumber "\<[0-9.]\+\>\.\?"
    syntax match MyPythonFunction /\v[[:alnum:]_]+\ze\s?\(/
    syntax match MyPythonUnpack '\*\*\?\ze[a-z]'
    syntax match MyPythonContainers /[][}{]/
    hi MyPythonSelf       cterm=none ctermfg=gray    ctermbg=none
    hi MyPythonLibrary    cterm=none ctermfg=gray    ctermbg=none
    hi MyPythonKwarg      cterm=none ctermfg=magenta ctermbg=none
    hi MyPythonNumber     cterm=none ctermfg=red     ctermbg=none
    hi MyPythonUnpack     cterm=none ctermfg=lightgray ctermbg=none
    hi def link MyPythonFunction Function
    hi def link MyPythonConstants Constant
  ]])
end

autocmd("FileType", "python", function()
  vim.bo.tabstop = 4
  vim.bo.shiftwidth = 4
  vim.bo.softtabstop = 4
  vim.bo.textwidth = 79
  python_syntax()
end)

----------------------------------------------------------------
-- Focus Movements
----------------------------------------------------------------

local function split_tab_pane_right()
  local win = vim.fn.winnr()
  vim.cmd("wincmd l")
  if win ~= vim.fn.winnr() then return end
  if vim.fn.tabpagenr() ~= vim.fn.tabpagenr("$") then
    vim.cmd("normal gt")
  else
    vim.fn.system("tmux select-pane -R")
  end
end

local function split_tab_pane_left()
  local win = vim.fn.winnr()
  vim.cmd("wincmd h")
  if win ~= vim.fn.winnr() then return end
  if vim.fn.tabpagenr() ~= 1 then
    vim.cmd("normal gT")
  else
    vim.fn.system("tmux select-pane -L")
  end
end

local function split_tab_down()
  local win = vim.fn.winnr()
  vim.cmd("wincmd j")
  if win == vim.fn.winnr() then
    vim.fn.system("tmux select-pane -D")
  end
end

local function split_pane_up()
  local win = vim.fn.winnr()
  vim.cmd("wincmd k")
  if win == vim.fn.winnr() then
    vim.fn.system("tmux select-pane -U")
  end
end

vim.keymap.set("n", "<C-h>", split_tab_pane_left,  { silent = true })
vim.keymap.set("n", "<C-l>", split_tab_pane_right, { silent = true })
vim.keymap.set("n", "<C-j>", split_tab_down,       { silent = true })
vim.keymap.set("n", "<C-k>", split_pane_up,        { silent = true })

----------------------------------------------------------------
-- Key bindings
----------------------------------------------------------------

-- Basic
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("i", "<C-v>", "<Esc>")
vim.keymap.set("v", "<C-c>", "<Esc>")
vim.keymap.set("v", "<C-v>", "<Esc>")
vim.keymap.set("v", "<C-u>", "u")
vim.keymap.set("n", "<C-c>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<C-t>", function()
  vim.fn.feedkeys(":tabe \t", "t")
end)
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null")
vim.keymap.set({ "n", "v" }, ";", ":")

-- Disable
vim.keymap.set("",  "q:",   "<nop>")
vim.keymap.set("",  "Q",    "<nop>")
vim.keymap.set("",  "<F1>", "<nop>")
vim.keymap.set("v", "u",    "<nop>")

-- Clipboard
vim.keymap.set("v", "ty", [[y:call system("tmux load-buffer -", @0)<CR>]])
vim.keymap.set("n", "tp", [[:let @0 = system("tmux save-buffer -")<CR>"0p]])
vim.keymap.set("n", "tP", [[:let @0 = system("tmux save-buffer -")<CR>"0P]])
vim.keymap.set("v", "tp", [[:let @0 = system("tmux save-buffer -")<CR>"0p]])
vim.keymap.set("v", "tP", [[:let @0 = system("tmux save-buffer -")<CR>"0P]])

-- Intel
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- Leader
vim.keymap.set("n", "<leader>a", "mzggVGy`z")
vim.keymap.set("n", "<leader>s", ":%s//g<Left><Left>")
vim.keymap.set("v", "<leader>s", ":s//g<Left><Left>")
vim.keymap.set("n", "<leader>f", "gwap")
vim.keymap.set("v", "<leader>f", "gw")
vim.keymap.set("n", "<leader>C", ":tab drop $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>S", ":tab drop ~/.vim/snippet/python.snippets<CR>")
vim.keymap.set("n", "<leader>q", "@q")
vim.keymap.set("n", "<leader>e", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>E", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>m", ":make<CR>")
vim.keymap.set("n", "<leader>h", ":cd %:h<CR>:pwd<CR>")
vim.keymap.set("n", "<leader>o", "vipo:sort<CR>")
vim.keymap.set("v", "<leader>o", ":sort<CR>")
vim.keymap.set("n", "<leader>j", "vipJ^")
vim.keymap.set("n", "<leader>x", "mzoimport sys; sys.exit()<Esc>`z")
vim.keymap.set("n", "<leader>i", "mzoimport ipdb; ipdb.set_trace()<Esc>`z")
vim.keymap.set("n", "<leader>t", "mzA  # TODO<Esc>`z")
vim.keymap.set("n", "<leader>p", '"0p')
vim.keymap.set("v", "<leader>p", '"0p')
vim.keymap.set("n", "<leader>y", "mzvipy`z")
vim.keymap.set("n", "<leader>k", "mzgcip`z", { remap = true })
vim.keymap.set("v", "<leader>k", "gc",       { remap = true })
