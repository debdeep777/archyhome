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
let g:tex_flavor='latex'

" Supposedly it can make the default output file to be pdf
let g:Tex_DefaultTargetFormat='pdf'


" Never Forget, To set the default viewer:: Very Important
let g:Tex_ViewRule_dvi = 'xdvi'
let g:Tex_ViewRule_pdf = 'zathura'
"let g:Tex_ViewRule_pdf = 'xpdf'

" add forward search capability through -src-specials
let g:Tex_CompileRule_dvi = 'latex -src-specials -interaction=nonstopmode $*'

" Trying to add same for pdfs, hoping that package SynTex is installed
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode $*'


" This is for dvi -> tex. Works!, to use it, need to launch vim with --servername sofun
let g:Tex_ViewRuleComplete_dvi = 'xdvi -editor "vim --servername dvisession --remote +\%l \%f" $*.dvi &'
"let g:Tex_ViewRuleComplete_pdf = 'zathura $*.pdf 2>/dev/nul &'
"
" Working!!!, when we run vim appropriately
let g:Tex_ViewRuleComplete_pdf = 'zathura -x "vim --servername nope --remote +\%{line} \%{input}" $*.pdf 2>/dev/nul &'

" This works in termnal, but not inside vimrc: zathura -x "vim --servername nope --remote +\%{line} \%{input}" db.pdf

"removing the menus from the gvim
"let g:Tex_Menus = 0

let g:Tex_Com_sum = "\\sum\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_cap = "\\bigcap\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_cup = "\\bigcup\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_lim = "\\lim\\limits\_{<++>}\^{<++>}<++>"

" Attempting to remove the need to hit enter while compiling through pdflatex
"map \ll :silent call Tex_RunLaTeX()<CR><CR>

" Forward search
" zathura --synctex-forward 193:1:paper.tex paper.pdf
" szathura %:r.pdf" line('.')  col('.') "%
" --unique %:p:r.pdf\\#src:".line(".")."%:p &"
function! SyncTexForward()
"     let execstr = "silent !zathura --synctex-forward %:p:r.pdf\\#src:".line(".")."%:p &"
	let execstr = 'silent! !zathura --synctex-forward '.line('.').':1:"'.expand('%').'" "'.expand("%:p:r").'".pdf'
	exec execstr 
endfunction
nmap <Leader>f :call SyncTexForward()<CR>
