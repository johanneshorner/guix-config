vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd.language("en_US.utf8")

-- indenting
vim.o.expandtab = true --tabs are spaces (thanks python)
vim.o.tabstop = 4 --number of visual spaces per TAB
vim.o.shiftwidth = 4
vim.o.softtabstop = 4 --number of spaces in tab when editing
vim.o.smartindent = true

-- search
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.incsearch = true

-- scrolling
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.wrap = true

vim.o.conceallevel = 0
vim.o.concealcursor = "nv"
vim.o.fileencoding = "utf-8"
vim.o.updatetime = 250
vim.o.termguicolors = true
vim.o.backup = false
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.hidden = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.cmdheight = 1
vim.o.undofile = true
vim.o.pumheight = 10
vim.o.laststatus = 3
vim.o.completeopt = "menuone,noselect"
vim.o.shortmess = vim.o.shortmess .. "I"

vim.wo.signcolumn = "yes"

vim.o.guifont = "SauceCodePro Nerd Font Mono"
