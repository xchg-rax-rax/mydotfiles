-------------------------------------------------------
-- A lightweight minimalist and very lazy neovim config
-------------------------------------------------------

-------------------
-- Useful variables
-------------------

local directions = { "h", "l", "k", "j" }
local arrows = { "Left", "Right", "Up", "Down" }
local modes = { "n", "i", "v", "x", "s", "c", "t" }

----------
-- Plugins
----------
-- Download lazy plugin manager if not present

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load and Setup plugins
local plugins  = require("plugins")
require("lazy").setup(plugins)
require('lualine').setup()

--------------------------------
-- General Configuration Options
--------------------------------

vim.opt.number = true
vim.opt.relativenumber = true 
vim.opt.laststatus = 2 -- alwasys show status bar
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.ts = 4	-- number of spaces per tab
vim.opt.sw = 4  -- number of spaces per auto-indent
vim.opt.showmatch = true -- show matching brackets
vim.opt.ruler = true -- show line,coloumn of cursor
vim.opt.smarttab = true -- infers the correct number of space per indent
vim.opt.path = ".,,**" -- paths to search when using :find (sus)

----------------------
-- Split Configuration
----------------------

vim.opt.splitbelow = true
vim.opt.splitright = true

-- This is stupid
vim.api.nvim_set_keymap(
    "n",
    "<BS>",
    "<C-w>h",
    {
        noremap = true
    }
)

local function generate_command(arrow)
    local command = ":"
    if arrow == "Left" or arrow == "Right" then
        command = command .. "vertical "
    end
    command = command .. "resize "
    if arrow == "Up" or arrow == "Right" then
        command = command .. "+3<CR>"
    else
        command = command .. "-3<CR>"
    end
    return command
end

for _, arrow in ipairs(arrows) do
    local command = generate_command(arrow)
    vim.api.nvim_set_keymap(
        "n",
        "<C-" .. arrow .. ">",
        command,
        {
            noremap = true,
            silent = true
        }
    )
end

-------------------------------
-- Disable F1 Help in All Modes
-------------------------------

for _, mode in ipairs(modes) do
    vim.api.nvim_set_keymap(
        mode,
        "<F1>",
        "<NOP>",
        {
            noremap = true,
            silent = true
        }
    )
end

-----------------------------
-- Configure Tab Key Bindings
-----------------------------

vim.api.nvim_set_keymap(
    "n",
    "<Tab>",
    "gt",
    {
        noremap = true,
        silent = true
    }
)
vim.api.nvim_set_keymap(
    "n",
    "<S-Tab>",
    "gT",
    {
        noremap = true,
        silent = true
    }
)
vim.api.nvim_set_keymap(
    "n",
    "T",
    ":tabnew<CR>",
    {
        noremap = true,
        silent = true
    }
)

------------------------------------------
-- Configure Spell Checker and Auto Correct
------------------------------------------

vim.opt.spell = true
vim.opt.spelllang = "en_gb"
vim.api.nvim_set_keymap(
    "i",
    "<C-l>",
    "<c-g>u<Esc>[s1z=`]a<c-g>u",
    {
        noremap = true,
        silent = true
    }
)

