local cmd = vim.cmd
local g   = vim.g
local opt = vim.opt
local api = vim.api
local fn  = vim.fn

vim.cmd [[packadd packer.nvim]]

-- List of packages https://github.com/rockerBOO/awesome-neovim
return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Command Palette
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config   = function() require'plugins.telescope' end,
  }

  -- Tree file view
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config   = function()
      require'nvim-tree'.setup {}
      vim.api.nvim_set_keymap('n', '<space>tre', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true })
    end,
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require'gitsigns'.setup{
        current_line_blame = true
      }
    end,
  }

  -- Syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = 'maintained',
        highlight        = {enable = true}
      }
      --vim.o.foldmethod = 'expr'
      --vim.o.foldexpr   = "nvim_treesitter#foldexpr()"
    end,
  }
  -- Language Server Protocol
  use {
    'neovim/nvim-lspconfig',
    config = function() require'plugins.lspconfig' end,
  }

  -- Completion using coq
  -- use {
  --   'ms-jpq/coq_nvim',
  --   branch = 'coq',
  --   config = function()
  --     vim.cmd 'autocmd BufEnter * COQnow -s'
  --   end,
  -- }
  -- use { 'ms-jpq/coq.artifacts', branch= 'artifacts'}

  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
    },
    config   = function()
      require'plugins.cmp'
    end
  }

  -- Theme
  use 'sainnhe/sonokai'
  require 'plugins.sonokai'  -- Activate sonokai theme

  -- Load .editorconfig file
  use 'editorconfig/editorconfig-vim'

  -- -- Statusline
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config   = function() require'plugins.lualine' end,
  }

  local function replace_code(str)
    return api.nvim_replace_termcodes(str, true, true, true)
  end
  function _G.smart_tab()
    return fn.pumvisible() == 1 and replace_code'<C-n>' or replace_code'<Tab>'
  end
  api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})

end)

