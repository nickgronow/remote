set shell=/bin/sh
set nocompatible

" Turn on syntax highlighting
syntax on

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.

" Case sensitivity
set ignorecase
set smartcase

" Global substitution
set gdefault

" Easier command selection
set wildmenu

" Allow windows to be closed without closing the file
set hidden

" Highlighting is good stuff
set hlsearch
set incsearch

" Cursor settings
set guicursor="i-ci:ver100iCursor-blinkwait1000-blinkon400-blinkoff300"
let &t_SI = "\<Esc>[5 q"
let &t_EI = "\<Esc>[2 q"

" Filetype stuff
filetype on
filetype plugin on
filetype indent on

" Leader key
let mapleader = " "

" Tabs
"
set tabstop=2
set smartindent
set shiftwidth=2
set autoindent
set expandtab

" Scrolling
set scrolloff=3

" Backspace in insert mode
set backspace=2

" Do not update the display when executing macros
set lazyredraw

" Show what mode you are in
set showmode

" Disable json quote concealing, we like our quotes
let g:vim_json_syntax_conceal = 0

" Hide those pesky mac files
let g:netrw_list_hide= '\.DS_Store$,.*\.swp$,^\./$'

" Strip HTML Tags
command! Htmlstrip execute "%s /<[a-zA-Z/].\{-}>//"

" Moving and copying files
let g:netrw_localmovecmd="mv"
let g:netrw_localcopycmd="cp"
let g:netrw_localmkdir="mkdir"
let g:netrw_localrmdir="rmdir"

" Relative line numbers by default
set nu
set rnu
"au WinEnter * :set rnu
"au WinLeave * :set nornu
"au InsertEnter * :set nornu
"au InsertLeave * :set rnu

" Status Line
set statusline=
set statusline +=\ %n\             "buffer number
set statusline +=%{&ff}            "file format
set statusline +=%y                "file type
set statusline +=\ %f            "full path
set statusline +=%m                "modified flag
set statusline +=%5l             "current line
set statusline +=/%L               "total lines
set statusline +=%4v\              "virtual column number
"set statusline +=%{fugitive#statusline()}
set laststatus=2

" Hidden characters
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Popup menu coloring
highlight Pmenu ctermfg=grey ctermbg=black
highlight PmenuSel ctermfg=darkgrey ctermbg=lightgrey

" Bg highlighting
highlight Normal ctermbg=none ctermfg=255
highlight NonText cterm=none

" Default filetypes to shell
autocmd BufNewFile,BufRead * if &ft == '' | set ft=sh | endif

" Active window highlighting
hi CursorLine cterm=none ctermbg=232 ctermfg=none
set cursorline
hi StatusLine ctermfg=darkblue ctermbg=black

" Visual highlighting
hi Visual  ctermfg=lightgrey ctermbg=darkgrey

augroup BgHighlight
    autocmd!
	autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
	autocmd WinEnter * hi StatusLine ctermfg=blue
    autocmd WinLeave * hi StatusLine ctermfg=white
augroup END

" wrapping
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function! ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
  endif
endfunction

" Environment sensitivity
function! SetupEnvironment()
  let l:path = expand('%:p')
  if l:path =~ '\v.*\.md'
    setlocal tabstop=4 shiftwidth=4
  endif
endfunction
autocmd! BufReadPost,BufNewFile * call SetupEnvironment()

" Key Mappings

" Copy all
nnoremap <leader>ca mzggyG'z

" Clear all
nnoremap <leader>da ggdG
nnoremap <leader>di ggdGi

" Get out of insert mode
inoremap <c-s> <esc>

" Toggle last buffer
nnoremap <leader>l :b#<cr>

" Save file
nnoremap <c-s> :up<cr>

" Search for any file
nnoremap <leader>oo :e **/

" Open buffers - MVC emphasis
nnoremap <leader>bb :b 
nnoremap <leader>vv :b views/*
nnoremap <leader>ss :b stylesheets/*
nnoremap <leader>jj :b javascripts/*
nnoremap <leader>mm :b models/*
nnoremap <leader>cc :b controllers/*
nnoremap <leader>tt :b spec/*
nnoremap <leader>dd :b migrat*/*
nnoremap <leader>bd :BufOnly<cr>

" Open files - ROR emphasis
nnoremap <leader>oa :e app/**/
nnoremap <leader>od :e db/migrate/*
nnoremap <leader>ov :e app/views/**/*
nnoremap <leader>os :e app/assets/stylesheets/**/*
nnoremap <leader>oj :e app/assets/javascripts/**/
nnoremap <leader>om :e app/models/
nnoremap <leader>oc :e app/controllers/**/
nnoremap <leader>op :e app/presenters/**/
nnoremap <leader>ot :e spec/**/
nnoremap <leader>mm :b app/models/*
nnoremap <leader>cc :b app/controllers/*
nnoremap <leader>pp :b app/presenters/*
nnoremap <leader>gd :noautocmd vimgrep /\(event\\|def\\|class\\|module\) .*\<<c-r><c-w>\>/ app/**/*.rb<cr>:e %<cr>

" Open common specific ROR files/directories
nnoremap <leader>og :e Gemfile<cr>
nnoremap <leader>or :e config/routes.rb<cr>
nnoremap <leader>on :e config/<cr>

" Reload file
nnoremap <leader>er :e! %<cr>

" Jump to start of line
nnoremap 0 ^

" Toggle paste mode
nnoremap <leader>pa :set paste!<cr>

" Deleting stuff goes into the black hole register
nnoremap d "_d

" Turn off that stupid highlight search
nnoremap  <leader>n :set hlsearch!<cr>

" Toggle line numbering on/off
nnoremap <leader>u :set rnu! nu!<cr>

" Ultra fast vim grep searching
nnoremap <leader>/ :noautocmd vimgrep /

" Get search result count - Disabled so it doesn't conflict with nerd
" commentor
nnoremap <leader>cs :%s///gn<cr>

" cd to the directory containing the file in the buffer
nmap  <leader>cd :lcd %:h

" Copy the current file path
nnoremap <leader>% :let @+ = expand("%")<cr>

" Insert lines
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>

" Column formatting
vnoremap <leader>fc :!column -t<cr>gv:s/\v ([^ ])/\1<cr>gv=

" Format JSON
com! FormatJSON %!python -m json.tool

" Increment
nnoremap <c-p> <c-a>

" Strip Empty Lines
command! -bar StripEmptyLines g/^\s*$/d

" Strip Newline characters
command! -bar StripNewLineCharacters %s/\\n//

" Strip HTML Tags
command! FormatHTML set ft=html|StripNewLineCharacters|%s/<[^>]*>/\r&\r/|StripEmptyLines|normal ggVG=

" Ruby convert string keys to symbol keys
command! ConvertStringKeysToSymbols s/\v['"]([^'"]*)['"]\s*\=\>/\1:/

" SQL formatting
command! FormatSQL silent! %s/\v<(from|join|where|order|group|having)>/\r&/e|silent! %s/\v [^,]+,/\r \0/e|nohlsearch|StripEmptyLines|normal gg

" Strip All
command! FormatAll set StripNewLineCharacters|StripEmptyLines|StripWhitespace
