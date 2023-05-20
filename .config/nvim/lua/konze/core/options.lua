local opt = vim.opt -- for conciseness

-- line number
-- opt.relativenumber = true
opt.number = true 

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false
-- TODO set to true for .tex and .txt

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
--opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- - <- dash is considered as part of the word (e.g. for jumping over words using w)
opt.iskeyword:append("-")

