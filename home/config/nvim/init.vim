"SETTINGS
let g:mapleader = "\<Space>"
syntax enable
set modifiable
set cursorline
set hidden
set nowrap
set encoding=utf-8
set pumheight=10
set fileencoding=utf-8
set ruler
set cmdheight=2
set iskeyword+=-
set mouse=a
set splitbelow
set splitright
set t_Co=256
set conceallevel=0
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set autoindent
set number
set relativenumber
set background=dark
set showtabline=2
set noshowmode
set nobackup
set nowritebackup
set updatetime=300
set timeoutlen=100
set formatoptions-=cro
set clipboard=unnamedplus
au! BufWritePost $MYVIMRC source %
cmap w!! w !sudo tee %


"MAPPINGS
inoremap <S-Space> <ESC>
nnoremap m h|xnoremap m h|onoremap m h|
nnoremap n j|xnoremap n j|onoremap n j|
nnoremap e k|xnoremap e k|onoremap e k|
nnoremap i l|xnoremap i l|onoremap i l|
nnoremap M H|xnoremap M H|onoremap M H|
nnoremap N J|xnoremap N J|onoremap N J|
nnoremap E K|xnoremap E K|onoremap E K|
nnoremap I L|xnoremap I L|onoremap I L|
nnoremap h i|xnoremap h i|onoremap h i|
nnoremap H I|xnoremap H I|onoremap H I|
nnoremap k n|xnoremap k n|onoremap k n|
nnoremap K N|xnoremap K N|onoremap K N|
nnoremap j m|xnoremap j m|onoremap j m|
nnoremap J M|xnoremap J M|onoremap J M|
nnoremap l e|xnoremap l e|onoremap l e|
nnoremap L E|xnoremap L E|onoremap L E|
nnoremap <C-s> :w<CR>
nnoremap <M-n> :resize -2<CR>
nnoremap <M-e> :resize +2<CR>
nnoremap <M-m> :vertical resize -2<CR>
nnoremap <M-i> :vertical resize +2<CR>
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>
vnoremap < <gv
vnoremap > >gv
nnoremap <C-q> :bd!<CR>
nnoremap <C-x> :bd#<CR>
tnoremap <C-q> :bd!<CR>
nnoremap <C-M> <C-W>h|xnoremap <C-M> <C-W>h|
nnoremap <C-N> <C-W>j|xnoremap <C-N> <C-W>j|
nnoremap <C-E> <C-W>k|xnoremap <C-E> <C-W>k|
nnoremap <C-I> <C-W>l|xnoremap <C-I> <C-W>l|

"STATUSLINE
"let right=""
"let left=""
set laststatus=2
set statusline=
set statusline+=%1*
set statusline+=\ %{ModeBruh()}\ 
set statusline+=%2*\%{GitBruh()}\ 
set statusline+=%3*\ %f\ 
set statusline+=%1*
set statusline+=%=
set statusline+=%3*\ %{strlen(&fenc)?&fenc:'none'}\ 
set statusline+=%2*\ %y\ 
let bruh="%  "
let bruh1="  "
set statusline+=%1*\ %p%{bruh}%l/%L%{bruh1}%c\ 

hi User1 guibg=#fbf1c7 guifg=#1d2021
hi User2 guibg=#1d2021 guifg=#fbf1c7
hi User3 guifg=#fbf1c7 guibg=#665c54

function! ModeBruh()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif

endfunction
function! GitBruh()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.'':''
endfunction

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction


set termguicolors
