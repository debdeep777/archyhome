
"" Turn off a plugin
"set runtimepath-=~/.vim/bundle/ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            mapping the Esc key                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap jk <Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Tab navigation                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" open the file under the cursor to edit in a new tab
nnoremap gf <C-W>gf

"" jump to the last activated tab
"if !exists('g:lasttab')
"  let g:lasttab = 1
"endif
"nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
"au TabLeave * let g:lasttab = tabpagenr()

" Alt
" Go to last active tab 
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>

"" Switching buffer opens a new tab
" doesn't work
"set switchbuf=usetab,newtab
"nnoremap <F8> :sbnext<CR>
"nnoremap <S-F8> :sbprevious<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Combine multiple blank lines into one                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> dc :<C-u>call <SID>CleanupBlanks()<CR>
fun! s:CleanupBlanks() abort
    if !empty(getline('.'))
        return
    endif
    let l:curr = line('.')

    let l:start = l:curr
    while l:start > 1 && empty(getline(l:start - 1))
        let l:start -= 1
    endwhile

    let l:end = l:curr
    let l:last_line_num = line('$')
    while l:end < l:last_line_num && empty(getline(l:end + 1))
        let l:end += 1
    endwhile

    if l:end >= l:start + v:count1
        exe l:start . '+' . v:count1 . ',' . l:end . 'd_'
    else
        call append(l:end, repeat([''], v:count1 - (l:end - l:start) - 1))
    endif
    call cursor(l:start, 1)
endfun

" Copy the most recently pasted section
nnoremap gp `[v`]


" source .vimrc after editing
" without restarting vim
" Not sure if I'll ever use it though
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <Leader>ev :tabe $MYVIMRC<CR>
" Automatically source vimrc in this file only on save.
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

" persistent undo, even after saving and closing
set undodir=~/.vimundo/ " a place to store the undo files, you need to create
                              " this directory: `mkdir -p ~/.vim/tmp/undo`
set undofile                  " turn of the feature
set undolevels=500           " maximum number of changes that can be undone
set undoreload=5000          " maximum number lines to save for undo on a buffer reload

" Ctrl+Backspace for deleting
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

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
map <Leader>o o<Esc>k
map <Leader>O O<Esc>j
"map oo o<Esc>k
"map OO O<Esc>j


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
set ic

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
" Looks cool though 
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
"let g:Tex_DefaultTargetFormat='pdf' "redundant since already included in
"tex.vim
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

"" Shutting down easymotion due to the conflict with vim-latex
"" """""""""""""""""""""""""""""""""""
"" "" easymotion settings
"" 
"" " mapping <Leader> instead of <Leader><Leader> as the trigger keystroke
 map <Leader> <plug>(easymotion-prefix)
"" "map <Tab> <plug>(easymotion-prefix)
"" 
"" 
"" " incsearch with links, press tab to scroll page
"" "map  / <plug>(easymotion-sn)
"" "omap / <plug>(easymotion-tn)
"" 
"" " added 
nmap s <plug>(easymotion-s2)
"" nmap t <plug>(easymotion-s2)
"" 
"" " Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
"map L <Plug>(easymotion-bd-jk)
"nmap L <Plug>(easymotion-overwin-line)

""""""""""""""""""""""""""""""""""
"" for lightline plugin
""""""""""""""""""""""""""""""""""
set laststatus=2
"let g:lightline = {
"      \ 'colorscheme': 'gruvbox',
"      \ }
"
"" From lightline-gruvbox.vim
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""
"" ranger.vim
""""""""""""""""""""""""""""""""""""
let g:ranger_map_keys = 0
"map <leader>r :Ranger<CR>
map <leader>r :RangerCurrentFileNewTab<CR>
"map <leader>r :RangerCurrentFileNewTab<CR>

" this is great! Ranger in the place of vim browser
let g:NERDTreeHijackNetrw = 0 "add this line if you use NERDTree
let g:ranger_replace_netrw = 1  "open ranger when vim open a directory

" show hidden files (zh) in the ranger instances automatically
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'



"""""""" vim-ranger
""let g:ranger_executable = 'ranger'
""let g:ranger_open_mode = 'tabe'

""""""""""""""""""""""""
"" gitgutter, shows unstaged changes at current file
""""""""""""""""""""""""""
" If there is any unstaged changes, the signcolumn pops up
" automatically when you open the file
"  so no need to do 
"set signcolumn=yes

""""""""""""""""""""""""""""""""""
" For ultisnips
"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"
" To use tab to both trigger and move forward
"let g:UltiSnips#ExpandSnippetOrJump="<tab>"
"
"" Set ultisnips triggers
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"
" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsEditSplit="context"

" Weird: To override the snippets defined in
" .vim/bundle/vim-snippets/UltiSnips
" and in .vim/bundle/vim-snipets/snippets
" I define my own using :UltiSnipsEdit. However, the location of this file
" is .vim/UltiSnips/, not any of the default files!
" Moreover, changing this parameter to another Directory causes the default
" snips to load. 
" I want to use all the default ones and then want my own snippets to have
" priority, in case of it is defined repeatedly.
" I guess two bugs together makes my purpose successful
" 'UltiSnips' = .vim/UltiSnips, not .vim/bundle/ultisnips!
let g:UltiSnipsSnippetDirectories = ['UltiSnips']


""""""""""""""""""""""""""
" vimtex
""""""""""""""""""""""""""
"" syntax folding enabled
let g:vimtex_fold_enabled = 1

"" Turn off automatic folding to speed up insert mode
let g:vimtex_fold_manual=1
"" Cleaner folding
set fillchars=fold:\ 
" Note: The |fold-expr| method of folding is well known to be slow, e.g. for
" long lines and large files. To speed things up, the user may want to
" enable the |g:vimtex_fold_manual| option. An alternative is to add
" a dedicated plugin that improves folding speed for the slow fold
" methods, e.g. https://github.com/Konfekt/FastFold.

" To turn it off in emergency 
"let g:vimtex_enabled = 1

" indentation for tex
let g:vimtex_indent_enabled = 0 


let g:vimtex_view_method = 'zathura'

" stop the selecting text in the first run
let g:vimtex_view_forward_search_on_start = 0
"let g:vimtex_quickfix_method = 'pplatex'
"

" Turning off some warning messages
   let g:vimtex_quickfix_latexlog = {
          \ 'default' : 1,
          \ 'ignore_filters' : ['Package nag Warning:', 'Package glossaries Warning:', 'Fira fonts' , 'snakes', 'Unused', 'contains only floats.', 'Token not allowed'],
          \ 'general' : 1,
          \ 'references' : 1,
          \ 'overfull' : 0,
          \ 'underfull' : 0,
          \ 'font' : 0,
          \ 'packages' : {
          \   'default' : 1,
          \   'general' : 1,
          \   'babel' : 1,
          \   'biblatex' : 1,
          \   'fixltx2e' : 1,
          \   'hyperref' : 1,
          \   'natbib' : 1,
          \   'scrreprt' : 1,
          \   'titlesec' : 1,
          \ },
          \}

" Stops from launching two instances of zathura in the beginning. Also the
" lag in compilation
let g:vimtex_view_automatic=0

" an alternate is to do the following
" but stops all the error and warning window, so it is useless
"let g:vimtex_compiler_latexmk = { 
"      \  'callback' : 0,
"      \}


" Turning off ALL warning messages
"let g:vimtex_quickfix_latexlog = {'default' : 0}


" disable opening quickfix window on warnings only 
"let g:vimtex_quickfix_open_on_warning = 0
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    fzf                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               vim-easy-align                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

