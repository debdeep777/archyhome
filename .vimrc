
" source .vimrc after editing
" without restarting vim
" Not sure if I'll ever use it though
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" Automatically source vimrc in this file only on save.
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd



" Thesaurus location to use with the plugin thesaurus_query
" Need mythes: `sudo apt-get install mythes-en-us` 
let g:tq_openoffice_en_file="/usr/share/mythes"
" downloaded form http://www.gutenberg.org/files/3202/files/
" old and had useless synomyms
let g:tq_mthesaur_file="~/Downloads/mthes/mthesaur.txt"

"exit vim 
noremap qq :q!<CR>


" Adding gaps before and after the current line
" for better formatting
"map <Leader>o o<Esc>k
"map <Leader>O O<Esc>j
map oo o<Esc>k
map OO O<Esc>j


" "to alias unnamed register to the + register, which is the clipboard
" Without this, you need to use "+y to copy text to clipboard to paste in
" firefox, for example. With the clipboard being plus, the copied text
" directly goes to +
set clipboard=unnamedplus

"What are these macros??!
let @w = 'maF>vf<yGop`an'
let @e = '10@wGV9ky'
let @i = '0x$xj'

" This one overrides the settings and restores defaults
"syntax on
"

" Using some color scheme, must have 
syntax enable


"colorscheme solarized
"let g:solarized_termcolors=256
"let g:solarized_diffmode="low"
"let g:solarized_contrast = "high"

" Abandoing solarized and welcoming gruvbox

" this is essential for correct reproduction of colors based on
" already set terminal colors. In my case, it is via a colorscheme
" for xfce4-terminal
set termguicolors
""""""""""""""""
colorscheme gruvbox

" moving this option to another file so that I can source it using
" a .myscript called themeset
"set background=dark
source ~/.vim/vimtheme

let g:gruvbox_contrast_light='medium'
let g:gruvbox_contrast_dark='medium'
" To change the contrast inside vim, you need to set
" the contrast variable and then reload the colorsheme
" e.g. :let g:gruvbox_constrast_light='soft'
"	:colorscheme gruvbox


"colorscheme blayu
" solarized colorscheme does not underline bad spelling
" you can change in colorscheme/solarized.vim  the option SpellBad to fmt_undr from fmt_curl
hi SpellBad cterm=underline

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
" making the choice to go ignore-case option
" to be case specific, use :set noic on demand
"set ic

" Experimental since I do not know if I need to get used to the original
" searching conventions
" search as characters are entered
set incsearch
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
" To copy from vim as you would copy from terminal
" hold down the Shift key while selecting text
" without entering visual mode
set mouse=a

" Make sure that there are always 3 lines above and below the cursor
" set scrolloff=3
"set scrolloff=999 " this will set the cursor in the middle of the screen


""" Set a line break after 80 chars
""" Caution: adds a new line to the line itself when the number of characters exceed the limit
""" set a colorcolumn
"set textwidth=69 	" word wrap after this, set this to zero to disable
"set colorcolumn =+1
"highlight ColorColumn ctermbg=lightgrey




" Let us try to write some text here. First, we try to write the following text
" for the rest of the text. then, we do the following. We carefully try to
" manage the thi


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


" Not working, don't know why
" Add blank lines before and after
"imap <C-j> <Esc>m`O<Esc>``i<CR>
"imap <C-k> <Esc>m`o<Esc>``i<CR>
"
"
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



"" Remapping i,j to relative
"" Messes with block selection
"nnoremap i gi
"nnoremap j gj

""""""""""""""""""""""""""""""""""""""""
" Plugin requirements
" Pathogen requirement
execute pathogen#infect()


" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin indent on



"""""""""""""""""""""""""""""""""""""""
" Vim-latex requirements 
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"" for bibtex compilation
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'

""""""""""""""""""""""""""""""""""""""

"vim-ledger requirement
"String that will be used to fill the space between account name and amount in
"the foldtext. Set this to get some kind of lines or visual aid.
 "let g:ledger_fillstring = '    -'
 "let g:ledger_maxwidth = 80

" Calendar requirement
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
let g:calendar_date_full_month_name = 1
let g:calendar_view = 'months'
"let g:calendar_clock_12hour = 1



""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up vertical vs block cursor for insert/normal mode
"" Other options (replace the number after \e[):
"
"    Ps = 0  -> blinking block.
"    Ps = 1  -> blinking block (default).
"    Ps = 2  -> steady block.
"    Ps = 3  -> blinking underline.
"    Ps = 4  -> steady underline.
"    Ps = 5  -> blinking bar (xterm).
"    Ps = 6  -> steady bar (xterm).
"
"    t_SI = Start Insert mode
"    t_EI = End insert mode
"    t_SR, r_ER = start and end replace mode
"
"if &term =~ "screen."
"    let &t_ti.="\eP\e[1 q\e\\"
"    let &t_SI.="\eP\e[5 q\e\\"
"    let &t_EI.="\eP\e[1 q\e\\"
"    let &t_te.="\eP\e[0 q\e\\"
"else
"    let &t_ti.="\<Esc>[1 q"
"    let &t_SI.="\<Esc>[5 q"
"    let &t_EI.="\<Esc>[1 q"
"    let &t_te.="\<Esc>[0 q"
"endif

" Usually there is a wait time set by ttimeoutlen and timeoutlen
" variables for which vim waits after <Esc> is pressed 
"" This is a great remap to avoid the waiting time after <Esc>
"inoremap <Esc> <Esc>
"" Here is another one
"inoremap <Esc> <Esc><Esc>

" This is responsible for changing cursor shape
let &t_SI.="\e[6 q"
let &t_EI.="\e[2 q"
let &t_SR.="\e[4 q"

"""""""""""""""""""""""""""""""""""
"" easymotion settings

" mapping <Leader> instead of <Leader><Leader> as the trigger keystroke
map <Leader> <Plug>(easymotion-prefix)


" incsearch with links, press tab to scroll page
map  / <plug>(easymotion-sn)
omap / <plug>(easymotion-tn)

" added 
nmap s <plug>(easymotion-s2)
nmap t <plug>(easymotion-s2)

" Move to line
"map <Leader>L <Plug>(easymotion-bd-jk)
"nmap <Leader>L <Plug>(easymotion-overwin-line)
map L <Plug>(easymotion-bd-jk)
nmap L <Plug>(easymotion-overwin-line)

