"this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:


""""""""""""""""""""""""'
" Default compiling format
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

" Get the correct servername, which should be the filename of the tex file,
" without the extension
" Using the filename, without the extension, not in uppercase though, but
" that's okay for a servername, it automatically get uppercased
let theuniqueserv = expand("%:t:r")

" Working!!!, when we run vim appropriately
"let g:Tex_ViewRuleComplete_pdf = 'zathura -x "vim --servername '.theuniqueserv.' --remote +\%{line} \%{input}" $*.pdf 2>/dev/nul &'
"Edit: Jul 2015: This %{input} only gives a relative file path, not useful.
"So,
"Here is the correct one.
let g:Tex_ViewRuleComplete_pdf = 'zathura -x "vim --servername '.theuniqueserv.' --remote +\%{line} '.expand('%:p').'" $*.pdf 2>/dev/nul &'

" This works in termnal, but not inside vimrc: zathura -x "vim --servername nope --remote +\%{line} \%{input}" db.pdf

"removing the menus from the gvim
"let g:Tex_Menus = 0

let g:Tex_Com_sum = "\\sum\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_cap = "\\bigcap\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_cup = "\\bigcup\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_lim = "\\lim\\limits\_{<++>\\to<++>}<++>"
let g:Tex_Com_int = "\\int\\limits\_{<++>}^{<++>}<++>"
let g:Tex_Com_Rn = "\\mathbb\{R\}\^n"

" Attempting to remove the need to hit enter while compiling through pdflatex
"map \ll :silent call Tex_RunLaTeX()<CR><CR>

" Forward search
" zathura --synctex-forward 193:1:paper.tex paper.pdf
function! SyncTexForward()
	let execstr = 'silent! !zathura --synctex-forward '.line('.').':1:"'.expand('%').'" "'.expand("%:p:r").'".pdf'
	execute execstr 
endfunction
nmap <Leader>f :call SyncTexForward()<CR><C-L>

" To save and compile with one command \k (k=kompile) :)
" no need to launch the pdf aliong with this because zathura can refresh
" itself after every compilation produces a new pdf, so \k is enough
nmap <Leader>k :w<CR> <Leader>ll<C-L>

" I will just reamp this \lv thing to \v just to be consistent with \k and \f
nmap <Leader>v <Leader>lv
