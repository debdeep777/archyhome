" suggested by itchyny from github
set clipboard=unnamed
"What are these macros??!
let @w = 'maF>vf<yGop`an'
let @e = '10@wGV9ky'
let @i = '0x$xj'

" This one overrides the settings and restores defaults
"syntax on

" Using the solarized color scheme, must have 
syntax enable
let g:solarized_termcolors=256
"let g:solarized_diffmode="low"
"let g:solarized_contrast = "high"

colorscheme solarized
set background=dark
" color scheme for a dark terminal setup,
" an alternative is pablo, but spellcheck highlight is ugly in that one
" although, tex files look nice in that one
" you'll get used to this one
"colorscheme slate

" Experimental. Remove if buggy.
" This is incredible. I like it.
" gt, gT to navigate through tabs
" :qa to quit all, :wqa to save and quit all, :qa! to quit all without saving 
" Most important of all:
" :tabo to close all other tabs except the current one
" Find out more for tab navigation
" set hidden actually lets you open another buffer by :o, :e etc even when the
" current file has unmodified changes. Fun!

"set hidden
":au BufAdd,BufNewFile * nested tab sball

" Searching
"""""""""""
" Experimental since I do not know if I need to get used to the original
" searching conventions
" search as characters are entered
"set incsearch
" Tired of clearing highlighted searches?
" pressing ,/ clears the previous highlights
"set hlsearch
"nmap <silent> ,/ :nohlsearch<CR>



" Really cool cursor-location-highlighting feature
" Makes my tex files very slow to navigate so i'm stopping them
" Works as a great chick-magnet though
" Can be underlined or highlighted, see help
set cursorline
" Used for keeping codes lined up
set cursorcolumn

" Setting up the hybrid numbering mode
set relativenumber 
set number 

" The paste mode toggle
set pastetoggle=<F2>

" Don't know
set linebreak

" Setting the spell check by highlighting
set spell

" mouse
set mouse=a

" Make sure that there are always 3 lines above and below the cursor
set scrolloff=3

" Keymaps
""""""""""""""""""""
" Killing the arrow keys to force the habit of using hjkl
noremap <up>    :echoerr 'USE K TO GO UP'<CR>
noremap <down>  :echoerr 'USE J TO GO DOWN'<CR>
noremap <left>  :echoerr 'USE H TO GO LEFT'<CR>
noremap <right> :echoerr 'USE L TO GO RIGHT'<CR>
" For insert mode also
inoremap <up>    <ESC>:echom 'USE K TO GO UP'<CR>
inoremap <down>  <ESC>:echom 'USE J TO GO DOWN'<CR>
inoremap <right> <ESC>:echom 'USE L TO GO RIGHT'<CR>
inoremap <left>  <ESC>:echom 'USE H TO GO LEFT'<CR>

" Ctrl+ L to spellcheck while typing
imap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Press F6 in normal mode or in insert mode to insert the current datestamp
" %F gives te ISO format which is useful is ledger, task warrior etc
nnoremap <F6> "=strftime("%F")<CR>P
inoremap <F6> <C-R>=strftime("%F")<CR>
" Here is the list of desired date time formats
" Format String              Example output
" -------------              --------------
"  %c                         Thu 27 Sep 2007 07:37:42 AM EDT (depends on
"  locale)
"  %a %d %b %Y                Thu 27 Sep 2007
"  %b %d, %Y                  Sep 27, 2007
"  %d/%m/%y %H:%M:%S          27/09/07 07:36:32
"  %H:%M:%S                   07:36:44
"  %T                         07:38:09
"  %m/%d/%y                   09/27/07
"  %y%m%d                     070927
"  %x %X (%Z)                 09/27/2007 08:00:59 AM (EDT)
"
"  RFC822 format:
"  %a, %d %b %Y %H:%M:%S %z   Wed, 29 Aug 2007 02:37:15 -0400
"
"  ISO8601/W3C format (http://www.w3.org/TR/NOTE-datetime):
"  %FT%T%z                    2007-08-29T02:37:13-0400


" The drop-down for autocomplete
set wildmenu

"" Smooth scrolling for Ctrl+D/U
"function SmoothScroll(up)
"    if a:up
"        let scrollaction=""
"    else
"        let scrollaction=""
"    endif
"    exec "normal " . scrollaction
"    redraw
"    let counter=1
"    while counter<&scroll
"        let counter+=1
"        sleep 10m
"        redraw
"        exec "normal " . scrollaction
"    endwhile
"endfunction
"
"nnoremap <C-U> :call SmoothScroll(1)<Enter>
"nnoremap <C-D> :call SmoothScroll(0)<Enter>
"inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
"inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

" Remapping i,j to relative
"nnoremap i gi
"nnoremap j gj

""""""""""""""""""""""""""""""""""""""""
" Plugin requirements
" Pathogen requirement
execute pathogen#infect()


" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin indent on


" Vim-latex requirements
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


"vim-ledger requirement
"String that will be used to fill the space between account name and amount in
"the foldtext. Set this to get some kind of lines or visual aid.
 "let g:ledger_fillstring = '    -'
 "let g:ledger_maxwidth = 80

" Calendar requirement
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
let g:calendar_date_full_month_name = 1
let g:calendar_view = 'days'
"let g:calendar_clock_12hour = 1

