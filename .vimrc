let @w = 'maF>vf<yGop`an'
let @e = '10@wGV9ky'
let @i = '0x$xj'
syntax on
set linebreak
set spell
"" Do not like visual bell anymore
"set visualbell
imap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u
set wildmenu

function SmoothScroll(up)
    if a:up
        let scrollaction=""
    else
        let scrollaction=""
    endif
    exec "normal " . scrollaction
    redraw
    let counter=1
    while counter<&scroll
        let counter+=1
        sleep 10m
        redraw
        exec "normal " . scrollaction
    endwhile
endfunction

nnoremap <C-U> :call SmoothScroll(1)<Enter>
nnoremap <C-D> :call SmoothScroll(0)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i


" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" can be called correctly.

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
"filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
"let g:tex_flavor='latex'

" Supposedly it can make the default output file to be pdf
"let g:Tex_DefaultTargetFormat='pdf'


" To change the default viewer
let g:Tex_ViewRule_dvi = 'xdvi'

" add forward search
let g:Tex_CompileRule_dvi = 'latex -src-specials -interaction=nonstopmode $*'

"test
let g:Tex_ViewRuleComplete_dvi = 'xdvi -editor "vim --servername xdvi --remote +\%l \%f" $* &'
