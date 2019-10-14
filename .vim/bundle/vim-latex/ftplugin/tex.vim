""""""""""""""""""""""""
"This file is created by Debdeep to set the compilation and viewing options
"Editing elsewhere is not advised because it will be re-written after an update 
""""""""""""""""""""""
"As suggested, this portion can be in ~/.vimrc as well
"
"this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

 
""""""""""""""""""""""""""""""""""""""""
""""auto-update "Last Change:" if present in the first 5 lines  whenever saving file
" Call the function s:timestamp() in tex files while writing to buffer
autocmd! BufWritePre *.tex :call s:timestamp()
" to update timestamp when saving if its in the first 5 lines of a file
function! s:timestamp()
    let pat = '\(Last Change\s*:\s*\).*'
    let rep = '\1' . strftime("%a %b %d %I:00 %p %Y")
    call s:subst(1, 5, pat, rep)
endfunction
" subst taken from timestamp.vim
" {{{1 subst( start, end, pat, rep): substitute on range start - end.
function! s:subst(start, end, pat, rep)
    let lineno = a:start
    while lineno <= a:end
	let curline = getline(lineno)
	if match(curline, a:pat) != -1
	    let newline = substitute( curline, a:pat, a:rep, '' )
	    if( newline != curline )
		" Only substitute if we made a change
		"silent! undojoin
		keepjumps call setline(lineno, newline)
	    endif
	endif
	let lineno = lineno + 1
    endwhile
endfunction
" }}}1

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
" `temporaty for compiling cv in xelatex
"let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode $*'



" This is for dvi -> tex. Works!, to use it, need to launch vim with --servername sofun
let g:Tex_ViewRuleComplete_dvi = 'xdvi -editor "vim --servername dvisession --remote +\%l \%f" $*.dvi &'
"let g:Tex_ViewRuleComplete_pdf = 'zathura $*.pdf 2>/dev/null &'

" Get the correct servername, which should be the filename of the tex file,
" without the extension
" Using the filename, without the extension, not in uppercase though, but
" that's okay for a servername, it automatically get uppercased
let theuniqueserv = expand("%:t:r")

" Working!!!, when we run vim appropriately
"let g:Tex_ViewRuleComplete_pdf = 'zathura -x "vim --servername '.theuniqueserv.' --remote +\%{line} \%{input}" $*.pdf 2>/dev/null &'
"Edit: Jul 2015: This %{input} only gives a relative file path, not useful.
"So,
"Here is the correct one.
let g:Tex_ViewRuleComplete_pdf = 'zathura -x "vim --servername '.theuniqueserv.' --remote +\%{line} '.expand('%:p').'" $*.pdf 2>/dev/null &'

" This works in termnal, but not inside vimrc: zathura -x "vim --servername nope --remote +\%{line} \%{input}" db.pdf

"Latex-related options, how to use them?""""""""""
"removing the menus from the gvim
"let g:Tex_Menus = 0

let g:Tex_Com_sum = "\\sum\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_prod = "\\prod\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_cap = "\\bigcap\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_cup = "\\bigcup\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_lim = "\\lim\\limits\_{<++>\\to<++>}<++>"
let g:Tex_Com_int = "\\int\\limits\_{<++>}^{<++>}<++>"
let g:Tex_Com_hat = "\\widehat{<++>}<++>"
let g:Tex_Com_min = "\\min\\limits\_{<++>}\^{<++>}\\left\\{<++> \\right\\}"
let g:Tex_Com_max = "\\max\\limits\_{<++>}\^{<++>}\\left\\{<++> \\right\\}"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""

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
