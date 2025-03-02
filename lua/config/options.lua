-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.mapleader = " "

vim.opt.fileencoding = "utf-8"

vim.o.foldcolumn = "1" -- Show fold column
vim.o.foldlevel = 99 -- Avoid auto-folding everything
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Use ufo for better folding experience
vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Disable backup files
vim.opt.writebackup = false -- Prevent backups before writing

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "fish"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "screen"
vim.opt.mouse = "a"
vim.opt.termguicolors = true -- Enable true color support

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- Autocommands for filetypes
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.astro" },
  command = "setfiletype astro",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Podfile" },
  command = "setfiletype ruby",
})

-- Adjust cmdheight for Neovim 0.11+
if vim.fn.has("nvim-0.11") == 1 then
  vim.opt.cmdheight = 0
else
  vim.opt.cmdheight = 1
end

vim.opt.statuscolumn = "%!v:lua.require'snacks.statuscolumn'.get()"

vim.keymap.set("n", "<leader>rn", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle Relative Numbers" })
