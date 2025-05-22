" ============= VIM-PLUG PLUGINS ================
if has('nvim')
  let vimplugdir='~/.config/nvim/plugged'
  let vimautoloaddir='~/.config/nvim/autoload'
else
  let vimplugdir='~/.vim/plugged'
  let vimautoloaddir='~/.vim/autoload'
endif

if empty(glob(vimautoloaddir . '/plug.vim'))
  " TODO: else?
  if executable('curl')
    execute 'silent !curl -fLo ' . vimautoloaddir . '/plug.vim --create-dirs ' .
          \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
  endif
endif

set nocompatible
filetype off

call plug#begin(vimplugdir)
" Lets get started
Plug 'tpope/vim-sensible' " sensible defaults

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Some Git stuff
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'
Plug 'tpope/vim-rhubarb' " GitHub integration
" Asynchronous dispatch
Plug 'tpope/vim-dispatch'
Plug 'airblade/vim-gitgutter' " Gutter for git
" EditorConfig
Plug 'editorconfig/editorconfig-vim'
" Execute code in current buffer
Plug 'huytd/vim-quickrun'
" Test things
Plug 'janko/vim-test'
" Language support things
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'cakebaker/scss-syntax.vim'
Plug 'ap/vim-css-color', { 'for': ['css', 'html'] }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" Add ability to format things with Black
Plug 'psf/black', { 'tag': '19.10b0', 'for': 'python' }
" LSP support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-denite'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'liuchengxu/vista.vim'
" Color Scheme
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/rainbow_parentheses.vim'
" Auto root folder switcher
Plug 'airblade/vim-rooter'
" Improving editing experience
Plug 'conormcd/matchindent.vim' " try to match indent style with the current file
Plug 'vim-scripts/matchit.zip' " Extend the % key
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish' " For case perserved subtitue :%S
Plug 'preservim/nerdcommenter' " Add sexy commenting functions
Plug 'terryma/vim-multiple-cursors'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" Scratchpad
Plug 'mtth/scratch.vim'
" Better management of swap files
Plug 'gioele/vim-autoswap'
" === Movement Plugins ===
Plug 'easymotion/vim-easymotion' " Easier Motion Movement
Plug 'haya14busa/incsearch.vim' " Highlight things as I search
Plug 'haya14busa/incsearch-easymotion.vim' " Integrate incsearch with easymotion
" TODOs in code
Plug 'vim-scripts/TaskList.vim'
" fzf replacement
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

filetype plugin indent on

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remember more commands and search history
set history=10000
" Needed for vim-devicons
set encoding=UTF-8
" coc.nvim needs these 3 set, see neoclide/coc.nvim#649
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300

" Automatically change to current directory
set autochdir

set mouse=a " enable mouse for all mode
set wildoptions=pum
set pumblend=20
set cursorline " Highlight what line our cursor is on
set rnu " Use relative line numbers

set foldmethod=indent
set foldlevel=99
set foldenable

" Set concealment of things like links in markdown
set conceallevel=2
" Don't hide code fences in markdown
let g:vim_markdown_conceal_code_blocks = 0

" display incomplete commands
set showcmd

let g:is_posix = 1

" zsh-style completion
set wildmode=full
" make tab completion for files/buffers act like bash
set wildmenu
set nojoinspaces
set nowrap
set number
set ttyfast
set laststatus=2
set ttimeout
set ttimeoutlen=10
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set shell=fish
set termguicolors
set ignorecase

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3

" Tweaks for git commits
au FileType gitcommit call s:gitcommit_mode_setup()
function! s:gitcommit_mode_setup()
  set tw=79
  set cc=80
endfunction

" Tweak for Markdown mode
autocmd FileType markdown call s:markdown_mode_setup()
function! s:markdown_mode_setup()
  set wrap
  set nonumber
  set textwidth=80
  set formatoptions+=t
endfunction

" Custom icon for coc.nvim statusline
let g:coc_status_error_sign=" "
let g:coc_status_warning_sign=" "

set t_Co=256
colorscheme gruvbox
" Slightly softer contrast
let g:gruvbox_contrast_dark="medium"

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
	syntax on
endif

" Defines how whitespace characters will appear
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
" Don't show whitespace characters by default
set nolist
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


"Whitespace defaults
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

set autoindent
set smartindent

" Persistent undo
" Don't forget mkdir folder $HOME/.vim/undo
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=1000
set undoreload=10000
" Use the system clipboard instead of internal
set clipboard+=unnamedplus

let g:NERDSpaceDelims = 1
map mm <Plug>NERDCommenterToggle

" === Easymotion and incsearch ===
" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and sometimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

" === End Easymotion and incsearch ===

" Floating Term
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm(...)
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let top = "╭" . repeat("─", width + 2) . "╮"
  let mid = "│" . repeat(" ", width + 2) . "│"
  let bot = "╰" . repeat("─", width + 2) . "╯"
  let lines = [top] + repeat([mid], height) + [bot]
  let bbuf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(bbuf, 0, -1, v:true, lines)
  let s:float_term_border_win = nvim_open_win(bbuf, v:true, border_opts)
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:Normal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:Normal')
  if a:0 == 0
    terminal
  else
    call termopen(a:1)
  endif
  startinsert
  " Close border window when terminal window close
  autocmd TermClose * ++once :bd! | call nvim_win_close(s:float_term_border_win, v:true)
endfunction


" === Keybindings ===
"
" disable keybindings that I don't use regularly
let g:scratch_no_mappings = 1
let mapleader="\<Space>"
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" when nested too deep
nnoremap <leader>x :set cursorcolumn!<cr>

" toggle numbers
map <leader># :set number!<cr>

" :W should really be :w because I never want :W and always mean :w
" :Q should really be :q because Q doesn't even do anything
" put them together and magic
command WQ wq
command Wq wq
command W w
command Q q

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
nnoremap H gT
nnoremap L gt
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PASTE MODE SANITY
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmode

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BIG RED UNWANTED WHITESPACE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /(\s\+$|\t)/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Turn off whitespaces compare and folding in vimdiff
set splitright
silent! set splitvertical
set diffopt+=iwhite
set diffopt+=vertical

" Fugitive diffing
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
nnoremap <Leader>2 :diffget 2<CR>:diffupdate<CR>
nnoremap <Leader>3 :diffget 3<CR>:diffupdate<CR>
if &diff
    syntax off
endif

" End fugitive diffing


function! DeleteCurrentFileAndBuffer()
  call delete(expand('%'))
  bdelete!
endfunction

function! DrawGitBranchInfo()
  let branch = fugitive#head()
  return len(branch) > 0 ? " " . branch : ""
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : '') : ''
endfunction

function! LightLineFilename()
  let name = ""
  let subs = split(expand('%'), "/")
  let i = 1
  for s in subs
    let parent = name
    if  i == len(subs)
      let name = len(parent) > 0 ? parent . '/' . s : s
    elseif i == 1
      let name = s
    else
      let part = strpart(s, 0, 10)
      let name = len(parent) > 0 ? parent . '/' . part : part
    endif
    let i += 1
  endfor
  return name
endfunction

function! LightlineTabname(n) abort
  let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let l:fname = expand('#' . l:bufnr . ':t')
  return l:fname =~# '^__Tagbar__' ? 'Tagbar' :
    \ l:fname == '__Mundo__' ? 'Mundo' :
    \ l:fname == '__Mundo_Preview__' ? 'Mundo Preview' :
    \ l:fname =~ 'NERD_tree' ? 'NERDTree' :
    \ l:fname =~ '\[coc-explorer\]-' ? 'Explorer' :
    \ l:fname =~ '\[Plugins\]' ? 'Plugins' :
    \ ('' != l:fname ? l:fname : '[No Name]')
endfunction

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], ['fileicon'], [ 'cocstatus' ], [ 'filename', 'readonly', 'modified' ] ],
      \   'right': [ [ 'icongitbranch' ], [ 'lineinfo' ], ]
      \ },
      \ 'inactive': {
      \   'left': [ [], ['fileicon'], [ 'filename' ] ],
      \   'right': []
      \ },
      \ 'component': { 'lineinfo': ' %2p%% %3l:%-2v' },
      \ 'component_function': {
      \   'fileicon': 'MyFiletype',
      \   'iconline': 'DrawLineInfo',
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \   'filename': 'LightLineFilename',
      \ },
      \ 'tab_component_function': {
      \   'filename': 'LightlineTabname',
      \ },
      \ 'colorscheme': 'gruvbox'
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC.nvim SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Use coc-explorer instead of NERDTree
nmap <Leader>e :CocCommand explorer<CR>
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Remap keys for gotos
nmap <silent> gd :call CocAction('jumpDefinition', 'drop')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Switch between cpp and h files
nnoremap <silent> gs :call CocAction('runCommand', 'clangd.switchSourceHeader')<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use L to highlight the symbol under the cursor
nnoremap <silent> L :call CocActionAsync('highlight')<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <plug>(coc-funcobj-i)
xmap af <plug>(coc-funcobj-a)
omap if <plug>(coc-funcobj-i)
omap af <plug>(coc-funcobj-a)

" remap for do codeaction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <plug>(coc-codeaction-selected)
nmap <leader>a  <plug>(coc-codeaction-selected)
" remap for do codeaction of current line
nmap <leader>ac  <plug>(coc-codeaction)
nmap <leader>ar  <plug>(coc-rename)
" fix autofix problem of current line
nmap <leader>qf  <plug>(coc-fix-current)
" jump to definition
nmap <silent>gd  <plug>(coc-definition)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" END coc.nvim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show the style name of thing under the cursor
" Shamelessly taken from https://github.com/tpope/vim-scriptease
function! FaceNames(...) abort
  if a:0
    let [line, col] = [a:1, a:2]
  else
    let [line, col] = [line('.'), col('.')]
  endif
  return reverse(map(synstack(line, col), 'synIDattr(v:val,"name")'))
endfunction

function! DescribeFace(count) abort
  if a:count
    let name = get(FaceNames(), a:count-1, '')
    if name !=# ''
      return 'syntax list '.name
    endif
  else
    echo join(FaceNames(), ' ')
  endif
  return ''
endfunction

nnoremap zs :<C-U>exe DescribeFace(v:count)<CR>

" Auto change root of the project
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['Cargo.tom', 'package.json', '.git/']

" Multiple Cursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<C-L>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<C-L>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-i>'
let g:multi_cursor_quit_key            = '<Esc>'

" Hacks to get colors working within tmux
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Some custom style
highlight Normal guibg=NONE
highlight EasyMotionTargetDefault guifg=#ffb400
highlight NonText guifg=#354751
highlight VertSplit guifg=#212C32
highlight link deniteSource_SymbolsName Symbol
highlight link deniteSource_SymbolsHeader String
highlight link deniteSource_grepLineNR deniteSource_grepFile
highlight WildMenu guibg=NONE guifg=#87bb7c
highlight CursorLineNr guibg=NONE

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_exclude_patterns = ['scp://.*']

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "
" I don't use recording, don't judge me
map q <Nop>
inoremap jk <ESC>
" Duplicate everything selected
vmap D y'>p

" Map Emacs like movement in Insert mode
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF                                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --ignore --glob "!Components/Testing/DataFiles/*" -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let spec = {'options': ['--nth', '4..', '--bind', 'ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all', '--delimiter', ':']}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Remap scrolling
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>

" Map <Leader>d to "delete without copying"
nnoremap d "_d
vnoremap d "_d


nnoremap <Leader>w :w<CR>
nnoremap <Leader>l :vsplit<CR>
nnoremap <Leader>k :split<CR>
nnoremap <Leader>wh :wincmd h<CR>
nnoremap <Leader>wl :wincmd l<CR>
nnoremap <Leader>wk :wincmd k<CR>
nnoremap <Leader>wj :wincmd j<CR>
nnoremap <Leader>w= :wincmd =<CR>
nnoremap <Leader>wb :e#<CR>
nnoremap <Leader>qq :bd<CR>
nnoremap <Leader>qk :call DeleteCurrentFileAndBuffer()<CR>
nnoremap <Leader>ss :mksession! .work<CR>
nnoremap <Leader>sr :so .work<CR>
nnoremap <Leader><Leader>r :so ~/.config/nvim/init.vim<CR>
" nnoremap <Leader>nt :NERDTreeToggle<CR>
" nnoremap <Leader>n :NERDTreeFind<CR>
"Buffer
nnoremap <Leader>tn :tabn<CR>
nnoremap <Leader>tp :tabp<CR>
nnoremap <Leader>tc :tabe<CR>
nnoremap <Leader>tx :tabclose<CR>

" Git mappings
nnoremap <Leader>g :Git<CR>
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR><CR>
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <Leader>gp :Ggrep<Space>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>
nnoremap <Leader>gps :Dispatch! git push<CR>
nnoremap <Leader>gpl :Dispatch! git pull<CR>

" Open terminal
nnoremap <Leader>at :call FloatTerm()<CR>
" Open node REPL
nnoremap <Leader>an :call FloatTerm('"node"')<CR>
" Open tig, yes TIG, A FLOATING TIGGGG!!!!!!
nnoremap <Leader>ag :call FloatTerm('"tig"')<CR>
nnoremap <Leader>ap :call FloatTerm('"python3"')<CR>

" Vim easymotion
map <Leader><Leader> <Plug>(easymotion-prefix)

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "
set smartcase
set autoread
autocmd BufRead,BufNewFile *.md setlocal spell

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" Set python to asdf python, then homebrew python, then system python
if !empty(glob('~/.asdf/shims/python'))
  let g:python_host_prog = system('echo -n (asdf which python2)')
  let g:python3_host_prog = system('echo -n (asdf which python3)')
elseif executable('brew')
  let g:python_host_prog = system('echo -n $(brew --prefix)') . '/bin/python'
  let g:python3_host_prog = system('echo -n $(brew --prefix)') . '/bin/python3'
else
  let g:python_host_prog = system('echo -n $(which python)')
  let g:python3_host_prog = system('echo -n $(which python3)')
endif

if filereadable(glob('~/.config/nvim/init.vim.local'))
  source ~/.config/nvim/init.vim.local
endif

" EditorConfig fix for null line length
let g:EditorConfig_disable_rules = ['max_line_length']

