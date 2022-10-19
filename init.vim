nnoremap <SPACE> <Nop>
nnoremap <Tab> <Nop>
let mapleader =" "

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
Plug 'jreybert/vimagit'
Plug 'lukesmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'antoinemadec/coc-fzf'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-fugitive'
Plug 'sbdchd/neoformat'
Plug 'itchyny/vim-gitbranch'
Plug 'wakatime/vim-wakatime'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'bkad/camelcasemotion'
Plug 'rhysd/clever-f.vim'
Plug 'preservim/nerdcommenter'
Plug 'keyvchan/vim-monokai'
Plug 'crusoexia/vim-javascript-lib'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'dikiaap/minimalist'
Plug 'yuezk/vim-js'
Plug 'mlaursen/vim-react-snippets'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-repeat'
Plug 'iamcco/markdown-preview.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'hankchiutw/nerdtree-ranger.vim'
Plug 'wellle/context.vim'
Plug 'mildred/vim-bufmru'
Plug 'peitalin/vim-jsx-typescript'
Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
call plug#end()

set title
set shiftwidth=2
set tabstop=2
set expandtab
set bg=dark
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set ignorecase
set smartcase
set scrolloff=7
set cursorline
set so=20
set nobackup
set nowb
set noswapfile
set hidden
set number relativenumber
set lazyredraw
set magic
let g:closetag_filenames = "*.js"
let s:hidden_all = 0
set noshowmode
set ruler
set laststatus=2
set showcmd
set conceallevel=3

map <C-l> :BufMRUNext<cr>
map <C-h> :BufMRUPrev<cr>
map <C-space> :BufMRUCommit<cr>
map <C-c> :bd<cr>
map <leader>, :edit ~/.config/nvim/init.vim<CR>
map { {zz
map } }zz
let python_highlight_all=1

" Auto resizing splits
autocmd VimResized * wincmd =

" colorscheme monokai
colorscheme monokai
set termguicolors
let g:vim_jsx_pretty_template_tags=['html','js','jsx','tsx']
:echo gitbranch#name()

" Some basics:
  nnoremap n nzz
  nnoremap N Nzz
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
  map <TAB> %
  map <leader>pi :PlugInstall<CR>
  map <leader>pc :PlugClean<CR>
  map <leader>S :source ~/.config/nvim/init.vim<CR>
  map <leader><leader> :w<CR>
  map <leader>q :q<CR>
  map <leader>wq :wq<CR>
  map <leader>l :bnext<cr>
  map <leader>h :bprevious<cr>

" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>
" Goyo plugin makes text more readable when writing prose:
	map <leader>m :Goyo \| set bg=dark \| set linebreak<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
 map <leader>h <C-w>h
 map <leader>j <C-w>j
 map <leader>k <C-w>k
 map <leader>l <C-w>l

" Replace ex mode with
	map Q @@

" Check file in shellcheck:
	" map <leader>sc :!clear && shellcheck -x %<CR>

"Open my bibliography file in split
"map <leader>b :vsp<space>$BIB<CR>
"map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>C :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=dark
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" " Function for toggling the bottom statusbar:
" let s:hidden_all = 1
" function! ToggleHiddenAll()
"     if s:hidden_all  == 0
"         let s:hidden_all = 1
"         set noshowmode
"         set noruler
"         set laststatus=0
"         set noshowcmd
"     else
"         let s:hidden_all = 0
"         set showmode
"         set ruler
"         set laststatus=2
"         set showcmd
"     endif
" endfunction
" nnoremap <leader>H :call ToggleHiddenAll()<CR>

" fzf
let g:fzf_layout = {'window':{'width':0.8,'height':0.8}}
nnoremap <leader>F :CocCommand fzf-preview.DirectoryFiles <CR>
nnoremap <leader>f :CocCommand fzf-preview.ProjectMruFiles<CR>
nnoremap <leader>d :CocCommand fzf-preview.CocDiagnostics<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>b :Buffer<CR>

let FZF_DEFAULT_COMMAND='rg --sort path --files --hidden --follow --no-messages -g \!"* *" -g !patches/**'
let FZF_DEFAULT_OPTS='-m --height 50% --border --reverse'
let $FZF_PREVIEW_PREVIEW_BAT_THEME="OneHalfDark"
let $BAT_THEME = 'OneHalfDark'
let g:fzf_preview_filelist_command = 'rg --sort path --files --hidden --follow --no-messages -g \!"* *" -g \!"patches/**"' " Installed ripgrep
let g:fzf_preview_directory_files_command = 'rg --sort path --files --hidden --follow --no-messages -g \!"* *" -g \!"patches/**"'
let g:fzf_preview_command = 'bat --color=always --theme="OneHalfDark" --plain {-1}' " Installed bat

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
" Fugitive
nmap <Leader>g [fzf-p]
xmap <Leader>g [fzf-p]

nnoremap <silent> [fzf-p]s     :Git<CR>
nnoremap <silent> [fzf-p]j     :diffget //2<CR>
nnoremap <silent> [fzf-p]k     :diffget //3<CR>
nnoremap <silent> [fzf-p]a     :CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]B     :CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p];     :CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap <silent> [fzf-p]ps    :Git push -u origin HEAD<CR>
nnoremap <silent> [fzf-p]pl    :Git pull<CR>
nnoremap <silent> [fzf-p]c     :GBranches<CR>
nnoremap <silent> [fzf-p]t     :Git stash<CR>
nnoremap <silent> [fzf-p]tp     :Git stash pop<CR>

" Coc
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <silent> <leader>R :CocCommand workspace.renameCurrentFile<CR>

" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

" gi - go to implementation
nmap <silent> gi <Plug>(coc-implementation)

" gr - find references
nmap <silent> gr <Plug>(coc-references)

" gh - get hint on whatever's under the cursor
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"" List errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<cr>

""multi-cursor
nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

"" Explorer
" nnmap <leader>e <Cmd>CocCommand explorer<CR>
nnoremap <leader>e :NERDTreeToggle %<CR>

" CamelCase
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie
sunmap w
sunmap b
sunmap e

" Airline

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme='murmur'
let g:airline_experimental = 1
let g:airline#extensions#coc#enabled = 1

" Markdwon preview
nmap <silent> <F8> <Plug>MarkdownPreview

" React Refactor
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>i :CocCommand tsserver.organizeImports<cr>
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
