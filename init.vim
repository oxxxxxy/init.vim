set number
set autoindent smartindent
set copyindent
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set mouse=a
set cursorline
set showmatch
set history=999
set undolevels=999
set autoread

call plug#begin()
  
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'https://github.com/LunarWatcher/auto-pairs', {'branch': 'develop-4.0.0'}
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/mg979/vim-visual-multi'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/Pocco81/AutoSave.nvim'

Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/williamboman/nvim-lsp-installer' 
Plug 'https://github.com/ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} 
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

call plug#end()

colorscheme deus 

lua << EOF

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
 
require('nvim-lsp-installer').setup( 
	{ 
    automatic_installation = true 
  }
) 

local lspconfig = require('lspconfig')
local coq = require('coq')

local servers = { 
	'denols',
	'clangd',
	'omnisharp',
	'asm_lsp',
	'bashls',
	'bicep',
	'crystalline',
	'cmake',
	'cssls',
	'dartls',
	'diagnosticls',
	'serve_d',
	'dockerls',
	'efm',
	'eslint',
	'elixirls',
	'elmls',
--	'erlangls',
	'fsautocomplete',
	'fortls',
	'gopls',
	'graphql',
--	'groovyls',
--	'hls',
	'haxe_language_server',
	'hoon_ls',
	'jsonls',
	'jdtls',
	'tsserver',
	'julials',
	'kotlin_language_server',
	'texlab',
	'sumneko_lua',
--	'nimls',
	'ocamllsp', 
	'opencl_ls',
	'psalm',
	'perlnavigator',
	'purescriptls',
	'pyright',
--	'r_language_server',
	'reason_ls',
	'robotframework_ls',
	'solargraph',
	'rust_analyzer',
	'sqls',
	'slint_lsp',
	'solang',
--	'sourcekit',
--	'verible',
	'taplo',
	'teal_ls',
	'tflint',
	'vls',
	'vala_ls',
	'vimls',
	'lemminx',
	'yamlls',
	'zls'
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup(
		coq.lsp_ensure_capabilities(
		  {} 
	  ) 
	)
end

lspconfig.html.setup(
	coq.lsp_ensure_capabilities(
		{
			capabilities = capabilities
		}
	)
)

require('autosave').setup({
	enabled = true
})

EOF

let g:coq_settings = { 'auto_start': 'shut-up' }

nnoremap <leader>v <cmd>CHADopen<cr> 
nnoremap <F8> <cmd>TagbarToggle<cr>
 
autocmd VimEnter * AutoPairsEnable
autocmd VimEnter * COQnow --shut-up
