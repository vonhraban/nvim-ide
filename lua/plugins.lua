-- lua/plugins.lua

-- Place where packer is goint to be saved
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Install packer from github if is not in our system
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Show packer messages in a popup. Looks cooler
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Alt installation of packer without a function
packer.reset()
local use = packer.use

--[[
  Start adding plugins here
]]
use({ -- Have packer manage itself
  "wbthomason/packer.nvim",
})
use({ -- Port of VSCode's Tokio Night theme
  "folke/tokyonight.nvim",
  config = function()
    vim.g.tokyonight_style = "night" -- Possible values: storm, night and day
  end,
})

use({ -- Install and configure tree-sitter languages
 "nvim-treesitter/nvim-treesitter",
 run = ":TSUpdate",
 config = function()
  require("config.treesitter")
 end,
})

use({ -- Configure LSP client and Use an LSP server installer.
 "neovim/nvim-lspconfig",
 requires = {
  "williamboman/nvim-lsp-installer", -- Installs servers within neovim
  "onsails/lspkind-nvim",            -- adds vscode-like pictograms to neovim built-in lsp
 },
 config = function()
  require("config.lsp")
 end,
})


use({ -- CMP completion engine
 "hrsh7th/nvim-cmp",
 requires = {
  "onsails/lspkind-nvim",     -- Icons on the popups
  "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
  "saadparwaiz1/cmp_luasnip", -- Snippets source
  "L3MON4D3/LuaSnip",         -- Snippet engine
  "hrsh7th/cmp-nvim-lsp-signature-help", -- function singature
},
 config = function()
  require("config.cmp")
 end,
})


-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if PACKER_BOOTSTRAP then
  require("packer").sync()
end

