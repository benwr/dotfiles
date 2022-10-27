" Plugins: {{{

  call plug#begin()
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/telescope.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'sainnhe/everforest'
    Plug 'kana/vim-textobj-user'
    Plug 'neovimhaskell/nvim-hs.vim'
    Plug 'Isti115/agda.nvim'
    Plug 'chrisbra/unicode.vim'
    Plug 'whonore/Coqtail'
    Plug 'benwr/lunicode'
  call plug#end()

  colors everforest

lua <<EOF
  -- local nvim_rocks = require('nvim_rocks')
  -- nvim_rocks.ensure_installed('luautf8')

  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    local mappings = {
      ['gD'] = '<Cmd>lua vim.lsp.buf.declaration()<CR>',
      ['gd'] = '<Cmd>lua vim.lsp.buf.definition()<CR>',
      ['gi'] = '<Cmd>lua vim.lsp.buf.implementation()<CR>',
      ['gr'] = '<Cmd>lua vim.lsp.buf.references()<CR>',
      ['K'] = '<Cmd>lua vim.lsp.buf.hover()<CR>',
      ['<C-k>'] = '<Cmd>lua vim.lsp.buf.signature_help()<CR>',
      ['<space>F'] = '<Cmd>lua vim.lsp.buf.formatting()<CR>',
      ['<space>dd'] = '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics({popup_opts={border="single"}})<CR>',
      ['<space>dn'] = '<Cmd>lua vim.lsp.diagnostic.goto_next({popup_opts={border="single"}})<CR>',
      ['<space>dp'] = '<Cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts={border="single"}})<CR>',
      }

    for keys, cmd in ipairs(mappings) do
      buf_set_keymap('n', keys, cmd, { noremap=true, silent=true })
    end

    nvim_lsp["pyright"].setup {
      on_attach = on_attach,
      flags = { debounce_text_changes = 150 },
    }

    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, {border="single"})

    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})
  end
EOF
" }}}
"
"

" When you do :buf [newbuf] from a terminal window, this prevents the terminal
" from being deleted
set hidden

" Don't show mode
set noshowmode

" try to get backup and undo working without extra steps
set backup
silent exec "!mkdir -p ~/.local/share/nvim/backup"
set backupdir=~/.local/share/nvim/backup

set undofile
silent exec "!mkdir -p ~/.local/share/nvim/undo"
set undodir=~/.local/share/nvim/undo

" tabs always get replaced by 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" long lines are broken on word boundaries and indented, with a ↳ indicator
set breakindent
set breakindentopt=shift:4,min:30,sbr
set showbreak=↳
set linebreak

" Ignore case in searching, unless I explicitly type capitals
set ignorecase
set smartcase
set nohlsearch

" Search incrementally
set incsearch

" Use system clipboard by default
set clipboard=unnamedplus

" Enable mouse support
set mouse=a

" (Legacy; this is default in nvim) turn on syntax highlighting
syntax on

" Line numbering that isn't crazy
set number
set relativenumber
set numberwidth=3

" Enable true color
if has("termguicolors")
  set termguicolors
endif

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=black guibg=black
match ExtraWhiteSpace /\s\+$/

" Highlight non-text characters (i.e. characters that are part of the UI)
highlight NonText guibg='NONE' guifg='lightgrey'

" Leader is space, localleader is \
let mapleader=" "
let maplocalleader="\\"

" Escape in the terminal actually escapes from the terminal insert mode
tnoremap <Esc> <C-\><C-n>
tnoremap <C-a>[ <C-\><C-n>

nnoremap <Leader>h :chdir ~<CR>
noremap <Leader>t :FindNextTerm<CR>
noremap <Leader>T :term<CR>
noremap <Leader>f <Cmd>Telescope find_files<CR>
noremap <Leader>g <Cmd>Telescope live_grep<CR>
noremap <Leader>b <Cmd>Telescope buffers<CR>

nnoremap <Leader>ev :tabe $MYVIMRC<CR>
nnoremap <Leader>rc :source $MYVIMRC<CR>

" This makes o/O enter insert mode properly in the terminal
nnoremap o A<Return>
nnoremap O I<Return><Up>

" Window management
noremap <C-w>c :tabnew<CR>
inoremap <C-w>c <Esc>:tabnew<CR>
noremap <C-w>n :tabn<CR>
inoremap <C-w>n <Esc>:tabn<CR>
noremap <C-w>N :tabm +1<CR>
inoremap <C-w>N <Esc>:tabm +1<CR>
noremap <C-w>p :tabp<CR>
inoremap <C-w>p <Esc>:tabp<CR>
noremap <C-w>P :tabm +1<CR>
inoremap <C-w>P <Esc>:tabm +1<CR>
noremap <C-w>" <C-w>s
inoremap <C-w>" <Esc><C-w>s
noremap <C-w>% <C-w>v
inoremap <C-w>% <Esc><C-w>v
noremap <C-w>x :close<CR>
inoremap <C-w>x <Esc>:close<CR>
inoremap <C-w>h <Esc><C-w>h
inoremap <C-w>j <Esc><C-w>j
inoremap <C-w>k <Esc><C-w>k
inoremap <C-w>l <Esc><C-w>l

" DIGRAPHS:

let g:lunicode_table = {
      \'To': '→',
      \'Times': '×',
      \'Meet': '∧',
      \'Join': '∨',
      \'Forall': '∀',
      \'Exists': '∃',
      \'Nexists': '∄',
      \'Null': '∅',
      \'In': '∈',
      \'Notin': '∉',
      \'Box': '∎',
      \'Star': '∗',
      \'Circle': '∘',
      \'Dot': '∙',
      \'Root': '√',
      \'Proportional': '∝',
      \'Inf': '∞',
      \'Intersection': '∩',
      \'Union': '∪',
      \'Integral': '∫',
      \'Therefore': '∴',
      \'Approx': '≈',
      \'Nequal': '≠',
      \'Equiv': '≡',
      \'Nequiv': '≢',
      \'Le': '≤',
      \'Ge': '≥',
      \'Psubset': '⊂',
      \'PSupset': '⊃',
      \'Subset': '⊆',
      \'Supset': '⊇',
      \'Turnstile': '⊢',
      \'Tulnstire': '⊣',
      \'Top': '⊤',
      \'Bot': '⊥',
      \
      \'Ba': '𝔸',
      \'Bb': '𝔹',
      \'Bc': 'ℂ',
      \'Bd': '𝔻',
      \'Be': '𝔼',
      \'Bf': '𝔽',
      \'Bg': '𝔾',
      \'Bh': 'ℍ',
      \'Bi': '𝕀',
      \'Bj': '𝕁',
      \'Bk': '𝕂',
      \'Bl': '𝕃',
      \'Bm': '𝕄',
      \'Bn': 'ℕ',
      \'Bo': '𝕆',
      \'Bp': 'ℙ',
      \'Bq': 'ℚ',
      \'Br': 'ℝ',
      \'Bs': '𝕊',
      \'Bt': '𝕋',
      \'Bu': '𝕌',
      \'Bv': '𝕍',
      \'Bw': '𝕎',
      \'Bx': '𝕏',
      \'By': '𝕐',
      \'Bz': 'ℤ',
      \
      \'Alph': 'α',
      \'Bet': 'β',
      \'Gamma': 'Γ',
      \'Gamm': 'γ',
      \'Delta': 'Δ',
      \'Delt': 'δ',
      \'Epsil': 'ε',
      \'Zet': 'ζ',
      \'Et': 'η',
      \'Theta': 'Θ',
      \'Thet': 'θ',
      \
      \'Kapp': 'κ',
      \'Lambda': 'Λ',
      \'Lambd': 'λ',
      \'Mu': 'μ',
      \'Nu': 'ν',
      \'Xia': 'Ξ',
      \'Xi': 'ξ',
      \'Pia': 'Π',
      \'Pi': 'π',
      \'Rho': 'ρ',
      \'Sigma': 'Σ',
      \'Sigm': 'σ',
      \'Tau': 'τ',
      \'Phia': 'Φ',
      \'Phi': 'φ',
      \'Psia': 'Ψ',
      \'Psi': 'ψ',
      \'Omega': 'Ω',
      \'Omeg': 'ω',
      \}

