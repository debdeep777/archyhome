
" Weird garbage character on vim 8.2 launch
" https://vimhelp.org/map.txt.html#modifyOtherKeys
let &t_TI = ""
let &t_TE = ""
" gx to launch urls in browser
" Doesn't work
"let g:netrw_browsex_viewer= "xdg-open"

" moving this option to another file so that I can source it using
" a .myscript called themeset
"set background=dark
source ~/.vim/vimtheme

" mapping the Esc key
inoremap jk <Esc>
cmap jk <Esc>

" set the size of the indenting of code (e.g. while using <, >, = etc)
set shiftwidth=4

" Disable getting into ex mode with Shift-Q (type visual to go back)
nnoremap Q <Nop>

"exit vim 
noremap qq :q!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Tab navigation                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open the file under the cursor to edit in a new tab
"nnoremap gf <C-W>gf
"" switch to tab if already open
"nnoremap gf <C-w>gf:call FavorExistingTabPage()<CR>
"
"function! FavorExistingTabPage()
"    let l:bufNr = bufnr('')
"    for l:i in range(1, tabpagenr('$'))
"        if l:i == tabpagenr()
"            continue    " Skip current.
"        endif
"        let l:winIndex = index(tabpagebuflist(l:i), l:bufNr)
"        if l:winIndex != -1
"            " We found the buffer elsewhere.
"            if l:i >= tabpagenr()
"                let l:i -= 1 " Adapt to removal of tab page before the current.
"            endif
"
"            close!
"
"            execute l:i . 'tabnext'
"            execute (l:winIndex + 1) . 'wincmd w'
"            break
"        endif
"    endfor
"endfunction

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
nmap <silent> <leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>ev :tab drop $MYVIMRC<CR>

" persistent undo, even after saving and closing
set undodir=~/.vimundo/ " a place to store the undo files, you need to create
                              " this directory: `mkdir -p ~/.vim/tmp/undo`
set undofile                  " turn of the feature
set undolevels=500           " maximum number of changes that can be undone
set undoreload=5000          " maximum number lines to save for undo on a buffer reload

" Ctrl+Backspace for deleting
" Caution: when `paste` mode is on (i.e. <f2> is pressed) this does not work
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

"" Jump to insert after the first word in the sentence, note the trailing space
"nmap <C-x> 0Ea 
"imap <C-x> <Esc>0Ea 
"" Jump to insert after the second to last word in the sentence, note the trailing space
"nmap <C-a> $bi 
"imap <C-a> <Esc>$bi 


"When a file has been detected to have been changed outside of Vim and
"it has not been changed inside of Vim, automatically read it again.
"When the file has been deleted this is not done.
set autoread

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

" This one overrides the settings and restores defaults
"syntax on
"

" Using some color scheme, must have 
syntax enable

hi SpellBad cterm=underline

" Searching
"""""""""""
" making the choice to go ignore-case option
" to be case specific, use :set noic on demand or use \C after the search
" string
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

" Make sure that there are always some lines above and below the cursor
"set scrolloff=1
"set scrolloff=999 " this will set the cursor in the middle of the screen

""" Set a line break after 80 chars
""" Caution: adds a new line to the line itself when the number of characters exceed the limit
""" set a colorcolumn
"set textwidth=69 	" word wrap after this, set this to zero to disable
"set colorcolumn =+1
"highlight ColorColumn ctermbg=lightgrey

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
"nnoremap <F6> "=strftime("%F")<CR>P
"inoremap <F6> <C-R>=strftime("%F")<CR>
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

"""""""""""""""""""""""""""""""""""""""""
" Required for vim-matlab to use % to jump between for ... end
"runtime macros/matchit.vim
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
" Specify a directory for plugins
" - For Neovim: std path('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

"" Plugins
"Plug 'tpope/vim-sensible'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/goyo.vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'preservim/nerdcommenter'
Plug 'francoiscabrol/ranger.vim' | Plug 'rbgrouleff/bclose.vim'
Plug 'junegunn/vim-easy-align'
"Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-eunuch'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'etdev/vim-hexcolor'
"Plug 'gko/vim-coloresque'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-sandwich'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'debdeepbh/vim-matlab',  { 'for': 'matlab' }
Plug 'jeetsukumaran/vim-indentwise'
Plug 'preservim/tagbar'
"Plug 'sjl/gundo.vim'
"Plug 'mbbill/undotree'
Plug 'simnalamburt/vim-mundo'

Plug 'vim-pandoc/vim-pandoc-syntax'
" Don't like syntax folding, don't use conversion of markdown to other formats
"Plug 'vim-pandoc/vim-pandoc'

"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'

" Automatic management of sessions using :Obsession instead of :mksession.
" (load sessions using vim -S Session.vim)
Plug 'tpope/vim-obsession'

Plug 'preservim/vimux'

"" Make sure you use single quotes
"
"" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'
"
"" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
"" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
"" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
"" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
"" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }
"
"" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
"" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"
"" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()


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
"if &term =~ 'screen.'
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
"set laststatus=1
set laststatus=2
"let g:lightline = {
"      \ 'colorscheme': 'gruvbox',
"      \ }
"
"" From lightline-gruvbox.vim
"let g:lightline.colorscheme = 'gruvbox'
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'cocstatus', 'readonly'],
	\		[ 'filename', 'modified' ],
	\     	    ],
	\   'right': [
	\		['lineinfo'],
	\		['percent'],
	\		['tagbar', 'fileencoding', 'filetype'],
	\     ],
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status',
	\   'gitbranch': 'gitbranch#name',
	\ },
	\ 'component': {
	\   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
	\ },
	\ }

""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""
"" ranger.vim
"" https://github.com/francoiscabrol/ranger.vim
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 	Color scheme gruvbox, needs to be _after_ calling the plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abandoing solarized and welcoming gruvbox

" this is essential for correct reproduction of colors based on already set terminal colors. In my case, it is via a colorscheme for xfce4-terminal
" Tuning this off since it causes tmux to produce black and white text only
"set termguicolors
""""""""""""""""


" enabling italics for vim 8.2
let g:gruvbox_contrast_light='medium'
let g:gruvbox_contrast_dark='medium'
" To change the contrast inside vim, you need to set
" the contrast variable and then reload the colorsheme

let g:gruvbox_italic=1

"Color scheme  needs to be set _after_ setting the options
colorscheme gruvbox8
"colorscheme blayu

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

"" [deprecated]
"" Turning off some warning messages
"   let g:vimtex_quickfix_latexlog = {
"          \ 'default' : 1,
"          \ 'ignore_filters' : ['Package nag Warning:', 'Package glossaries Warning:', 'Fira fonts' , 'snakes', 'Unused', 'contains only floats.', 'Token not allowed'],
"          \ 'general' : 1,
"          \ 'references' : 1,
"          \ 'overfull' : 0,
"          \ 'underfull' : 0,
"          \ 'font' : 0,
"          \ 'packages' : {
"          \   'default' : 1,
"          \   'general' : 1,
"          \   'babel' : 1,
"          \   'biblatex' : 1,
"          \   'fixltx2e' : 1,
"          \   'hyperref' : 1,
"          \   'natbib' : 1,
"          \   'scrreprt' : 1,
"          \   'titlesec' : 1,
"          \ },
"          \}

    " Disable custom warnings based on regexp
let g:vimtex_quickfix_ignore_filters = [
	  \ 'Package nag Warning:', 'Package glossaries Warning:', 'Fira fonts' , 'snakes', 'Unused', 'contains only floats.', 'Token not allowed'
          \]


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
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>t :Buffers<CR>
nnoremap <silent> <Leader>g :GFiles?
nnoremap <silent> <Leader>]  :Tags<CR>
nnoremap <silent> <Leader>b] :BTags<CR>

" Moving to buffer-based project management from tabs
" modify default actions
"let g:fzf_action = {
      "\ 'enter': 'tab drop',
      "\ 'ctrl-t': 'tab drop',
      "\ 'ctrl-x': 'split',
      "\ 'ctrl-v': 'vsplit' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Hide statusline
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Custom statusline
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()


""" Mapping selecting mappings
"nmap <leader><tab> <plug>(fzf-maps-n)
"xmap <leader><tab> <plug>(fzf-maps-x)
"omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               vim-easy-align                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  coc.nvim                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" disable annoying warning
let g:coc_disable_startup_warning = 1

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

"" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

""" I like auto signcolumn adjustment
"" Always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
"set signcolumn=yes
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"" We want to trigger completion on Tab
"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
"" position. Coc only does snippet and additional edit on confirm.
"if exists('*complete_info')
"  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
"  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif

""" This hack did not work
"" https://github.com/neoclide/coc.nvim/issues/617
"" Endwise
"" disable mapping to not break coc.nvim (I don't even use them anyways)
" let g:endwise_no_mappings = 1

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
" GoTo code navigation.
"nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"
"" Use K to show documentation in preview window.
noremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" interferes with <leader>r to launch ranger
nmap <leader><S-R> <Plug>(coc-rename)
"nmap <leader><f2> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.)
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Use auocmd to force lightline update.
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Mappings using CoCList:
" Show all diagnostics.
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
""nnoremap <silent> <leader>ll  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" json comment character // matching in :CocConfig
autocmd FileType json syntax match Comment +\/\/.\+$+
""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            :terminal tab change                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim mode in terminal interferes with this
"" So I keep using the default keys
"tnoremap <Esc> <C-\><C-n>
tnoremap gt <C-\><C-n>gt



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              vim-slime target                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:slime_target = "x11"

let g:slime_target = "vimterminal"

"" For tmux
"let g:slime_target = "tmux"
"let g:slime_paste_file = "$HOME/.slime_paste"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                vim-fugitive                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"statusline+=%{FugitiveStatusline()}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 vim-matlab                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Apply to filetype .m only: autocmd BufEnter *.m
" There should another easy way to make them apply to a particular filetype.
" One way is to include commands inside `ftplugin` directory of the plugin.
" Set the compiler
" Create a soft link in `/usr/local/bin/` of `mlint` using
" sudo ln -s /usr/local/MATLAB/R2020a/bin/glnxa64/mlint /usr/local/bin/mlint
autocmd BufEnter *.m    compiler mlint 
"Now, after opening a .m file, we can issue `:make` and then `:copen` to see error messages. We can combine these options together and another line to the file `ftplugin/matlab.vim`
"This launches the errors when we press `\ll`, to be consistent with latex shortcut.
autocmd BufEnter *.m     map <silent> <Leader>ll :make<CR>:copen<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             vim-pandoc-syntax                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use :set cole=0 to disable concealing the markdown elements
" Use :PanddocHighlight python to highlight all codeblocks that are specified
" as python blocks that start with python
"
"" No need to use this when using vim-pandoc
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Zotero better-bibtex plugin                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'cite' : 'pandoc'
  let api_call = 'http://127.0.0.1:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction

noremap <leader>z "=ZoteroCite()<CR>p


inoremap <C-z> <C-r>=ZoteroCite()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   tagbar                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F8> :TagbarToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   gundo                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <F5> :GundoToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  undotree                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <F5> :UndotreeToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   mundo                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F5> :MundoToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   vimux                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prompt for a command to run
map <leader>vp :VimuxPromptCommand<cr>
" Run last command executed by VimuxRunCommand
map <leader>vl :VimuxRunLastCommand<cr>
" Inspect runner pane
map <leader>vi :VimuxInspectRunner<cr>
" Zoom the tmux runner pane
map <leader>vz :VimuxZoomRunner<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Fixing broken things                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Who killed my ctrl-i? (:verbose nmap <c-i> does not show anything)
:nnoremap <C-i> <C-i>

