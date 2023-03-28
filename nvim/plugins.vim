" Install with :PlugInstall
" Update with :PlugUpdate
" Remove with :PlugClean
" Upgrade vim-plug with :PlugUpgrade
"
" Plugins are installed to $HOME/.local/share/nvim/plugged

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" for installation of LSP's. Run this command when starting with 
" new languages and file types.
" :Mason
" :MasonUpdate
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'williamboman/mason-lspconfig.nvim'

" :LspInfo
Plug 'neovim/nvim-lspconfig'

" :TSInstallInfo
" :TSUpdate
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'alexandervantrijffel/vim-material'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'easymotion/vim-easymotion'

Plug 'github/copilot.vim'

Plug 'lewis6991/gitsigns.nvim'

Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install' }

Plug 'antoinemadec/coc-fzf'

Plug '907th/vim-auto-save'

" Smooth scrolling
Plug 'yuttie/comfortable-motion.vim'

" Comment out line
Plug 'tpope/vim-commentary'

" Git wrapper
Plug 'tpope/vim-fugitive'
" :GV! view commit log of current file
" :GV -S foobar -- src view commit log
Plug 'junegunn/gv.vim'

" Plug 'tpope/vim-surround'

" Change color of #986456 hexcodes in text
Plug 'ap/vim-css-color'

" Bottom status bar and top bar
Plug 'nvim-tree/nvim-web-devicons'

Plug 'nvim-lualine/lualine.nvim'

" Rainbow parentheses
Plug 'luochen1990/rainbow'

Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" Yet Another TypeScript Syntax
Plug 'HerringtonDarkholme/yats.vim'

" change working directory to project root
" Plug 'airblade/vim-rooter'

" :Far and :Far (interactive) - find and replace in multiple files
Plug 'brooth/far.vim'


" Plug 'tell-k/vim-autopep8'
" Plug 'tomlion/vim-solidity'

Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'jose-elias-alvarez/null-ls.nvim'

Plug 'kwkarlwang/bufjump.nvim'

call plug#end()

source $XDG_CONFIG_HOME/nvim/pluginconfig.vim
