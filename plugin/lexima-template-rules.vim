" Lexima rules for web templates.
" Copyright © 2016 Zandr Martin

" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the "Software"),
" to deal in the Software without restriction, including without limitation
" the rights to use, copy, modify, merge, publish, distribute, sublicense,
" and/or sell copies of the Software, and to permit persons to whom the
" Software is furnished to do so, subject to the following conditions:

" The above copyright notice and this permission notice shall be included
" in all copies or substantial portions of the Software.

" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
" OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
" DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
" TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
" OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

" call the function first so it gets autoloaded, if it's there
silent! call lexima#add_rule()

" now check to see if it exists, since it will have been loaded
if !exists('*lexima#add_rule')
    echoerr 'You must have Lexima installed and running to use this plugin.'
    finish
endif

if exists('g:lexima_template_rules_loaded') && g:lexima_template_rules_loaded
    augroup lexima_template_rules
        autocmd!
    augroup END
    finish
endif

let g:lexima_template_rules_loaded = 1
let g:lexima_template_rules_endset = get(g:, 'lexima_template_rules_endset', 0)

let s:save_cpo = &cpo
set cpo&vim

let s:filetypes = [
    \ 'django',
    \ 'html',
    \ 'htmldjango',
    \ 'htmljinja',
    \ 'jinja',
    \ 'liquid',
    \ 'mako',
    \ 'twig',
    \ 'xml',
    \ ]

augroup lexima_template_rules
    autocmd!
    exec 'autocmd FileType '.join(s:filetypes, ',').' call lexima#template_rules#add_rules()'
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: fdm=marker
