vim.opt.runtimepath:append(',~/.config/nvim/lua,~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/parser')


require('options')
require('keymaps')
require('plugins');

vim.cmd[[silent! colorscheme tokyonight]]

