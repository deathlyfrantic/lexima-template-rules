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

function! lexima#template_rules#add_rules()
    augroup lexima_template_rules
        autocmd!
    augroup END

    " basic html/xml tag delimiters {{{
    call lexima#add_rule({
        \ 'char': '<',
        \ 'input_after': '>',
        \ 'filetype': ['html', 'jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig', 'mako', 'xml'],
        \ })
    call lexima#add_rule({
        \ 'char': '>',
        \ 'at': '\%#>',
        \ 'leave': 1,
        \ 'filetype': ['html', 'jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig', 'mako', 'xml'],
        \ })
    call lexima#add_rule({
        \ 'char': '<BS>',
        \ 'at': '<.*>\%#',
        \ 'input': '<BS>',
        \ 'input_after': '>',
        \ 'filetype': ['html', 'jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig', 'mako', 'xml'],
        \ })
    call lexima#add_rule({
        \ 'char': '<BS>',
        \ 'at': '<.*/>\%#',
        \ 'input': '<BS><BS>',
        \ 'input_after': '/>',
        \ 'filetype': ['html', 'jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig', 'mako', 'xml'],
        \ 'priority': 1,
        \ })
    call lexima#add_rule({
        \ 'char': '/',
        \ 'leave': 2,
        \ 'at': '^\s*<.*\%#\s*/>',
        \ 'filetype': ['html', 'jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig', 'mako', 'xml'],
        \ })
    call lexima#add_rule({
        \ 'char': '<BS>',
        \ 'delete': 1,
        \ 'at': '<\%#>',
        \ 'filetype': ['html', 'jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig', 'mako', 'xml'],
        \ })
    call lexima#add_rule({
        \ 'char': '<BS>',
        \ 'delete': 2,
        \ 'at': '<\%#/>',
        \ 'filetype': ['html', 'jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig', 'mako', 'xml'],
        \ 'priority': 1,
        \ })
    call lexima#add_rule({
        \ 'char': '/',
        \ 'delete': 1,
        \ 'input': '/>',
        \ 'at': '<[^>]\+\%#>',
        \ 'filetype': ['html', 'jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig', 'mako', 'xml'],
        \ })
    call lexima#add_rule({
        \ 'char': '<CR>',
        \ 'input': '<CR>',
        \ 'input_after': '<CR>',
        \ 'at': '>\%#</',
        \ 'filetype': ['html', 'jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig', 'mako', 'xml'],
        \ })
    " }}}

    " jinja/django/liquid/twig templates {{{
    let s:chars = [
        \ {'char': '%', 'filetypes': ['jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig',]},
        \ {'char': '#', 'filetypes': ['jinja', 'htmljinja', 'django', 'htmldjango', 'twig',]},
        \ ]

    call lexima#add_rule({
        \ 'char': '}',
        \ 'at': '\%#}}',
        \ 'leave': 2,
        \ 'filetype': ['jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig',],
        \ })
    call lexima#add_rule({
        \ 'char': '}',
        \ 'at': '\%# }}',
        \ 'leave': 3,
        \ 'filetype': ['jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig',],
        \ })

    call lexima#add_rule({
        \ 'char': '<BS>',
        \ 'at': '}}\%#',
        \ 'input': '<BS><BS><BS>',
        \ 'input_after': ' }}',
        \ 'filetype': ['jinja', 'htmljinja', 'django', 'htmldjango', 'liquid', 'twig',],
        \ })

    for c in s:chars
        call lexima#add_rule({
            \ 'char': c.char,
            \ 'at': '{\%#}',
            \ 'input_after': c.char,
            \ 'filetype': c.filetypes
            \ })
        call lexima#add_rule({
            \ 'char': c.char,
            \ 'at': '\%#'.c.char.'}',
            \ 'leave': 2,
            \ 'filetype': c.filetypes
            \ })
        call lexima#add_rule({
            \ 'char': '<BS>',
            \ 'at': '{'.c.char.'\%#'.c.char.'}',
            \ 'delete': 1,
            \ 'filetype': c.filetypes
            \ })
        call lexima#add_rule({
            \ 'char': '<BS>',
            \ 'at': '{'.c.char.' \%# '.c.char.'}',
            \ 'delete': 1,
            \ 'filetype': c.filetypes
            \ })
        call lexima#add_rule({
            \ 'char': '<BS>',
            \ 'at': ' '.c.char.'}\%#',
            \ 'input': '<BS><BS><BS>',
            \ 'input_after': ' '.c.char.'}',
            \ 'filetype': c.filetypes
            \ })
        call lexima#add_rule({
            \ 'char': c.char,
            \ 'at': '\%# '.c.char.'}',
            \ 'leave': 3,
            \ 'filetype': c.filetypes
            \ })
        call lexima#add_rule({
            \ 'char': '<Space>',
            \ 'at': '{'.c.char.'\%#'.c.char.'}',
            \ 'input': '<Space>',
            \ 'input_after': '<Space>',
            \ 'filetype': c.filetypes
            \ })
    endfor

    let s:template_tags = [
        \ {'tag': 'autoescape', 'filetypes': ['jinja', 'htmljinja', 'django', 'htmldjango', 'twig',]},
        \ {'tag': 'block'     , 'filetypes': ['jinja', 'htmljinja', 'django', 'htmldjango', 'twig',]},
        \ {'tag': 'blocktrans', 'filetypes': ['django', 'htmldjango',]},
        \ {'tag': 'call'      , 'filetypes': ['jinja', 'htmljinja',]},
        \ {'tag': 'capture'   , 'filetypes': ['liquid',]},
        \ {'tag': 'case'      , 'filetypes': ['liquid',]},
        \ {'tag': 'comment'   , 'filetypes': ['django', 'htmldjango', 'liquid',]},
        \ {'tag': 'embed'     , 'filetypes': ['twig',]},
        \ {'tag': 'filter'    , 'filetypes': ['jinja', 'htmljinja', 'django', 'htmldjango', 'twig',]},
        \ {'tag': 'for'       , 'filetypes': ['jinja', 'htmljinja', 'django', 'htmldjango', 'twig', 'liquid',]},
        \ {'tag': 'if'        , 'filetypes': ['jinja', 'htmljinja', 'django', 'htmldjango', 'twig', 'liquid',]},
        \ {'tag': 'ifequal'   , 'filetypes': ['django', 'htmldjango',]},
        \ {'tag': 'ifnotequal', 'filetypes': ['django', 'htmldjango',]},
        \ {'tag': 'ifchanged' , 'filetypes': ['django', 'htmldjango',]},
        \ {'tag': 'macro'     , 'filetypes': ['jinja', 'htmljinja', 'twig',]},
        \ {'tag': 'raw'       , 'filetypes': ['jinja', 'htmljinja', 'liquid',]},
        \ {'tag': 'sandbox'   , 'filetypes': ['twig',]},
        \ {'tag': 'spaceless' , 'filetypes': ['django', 'htmldjango', 'twig',]},
        \ {'tag': 'tablerow'  , 'filetypes': ['liquid',]},
        \ {'tag': 'trans'     , 'filetypes': ['jinja', 'htmljinja',]},
        \ {'tag': 'unless'    , 'filetypes': ['liquid',]},
        \ {'tag': 'verbatim'  , 'filetypes': ['django', 'htmldjango', 'twig',]},
        \ {'tag': 'with'      , 'filetypes': ['jinja', 'htmljinja', 'django', 'htmldjango',]},
        \ ]

    if g:lexima_template_rules_endset
        let s:template_tags = add(s:template_tags, {'tag': 'set', 'filetypes': ['jinja', 'htmljinja', 'twig',]})
    endif

    for t in s:template_tags
        call lexima#add_rule({
            \ 'char': '<CR>',
            \ 'input': '<CR>',
            \ 'input_after': '<CR>{% end'.t.tag.' %}',
            \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1.*end'.t.tag,
            \ 'at': '^\s*{%\s*\%('.t.tag.'\).*%}\%#',
            \ 'filetype': t.filetypes,
            \ })
    endfor
    " }}}

    " mako {{{
    for mt in ['def', 'block', 'doc', 'text', 'call',]
        call lexima#add_rule({
            \ 'char': '<CR>',
            \ 'input': '<CR>',
            \ 'input_after': '<CR></%'.mt.'>',
            \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1.*\</\%'.mt,
            \ 'at': '^\s*<%'.mt.'.*>\%#',
            \ 'filetype': 'mako',
            \ })
    endfor

    for mt in ['if', 'for',]
        call lexima#add_rule({
            \ 'char': '<CR>',
            \ 'input': '<CR>',
            \ 'input_after': '<CR>% end'.mt,
            \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1.*\% end'.mt,
            \ 'at': '^\s*% '.mt.'.*\%#',
            \ 'filetype': 'mako',
            \ })
    endfor

    for mt in ['page', 'include', 'namespace', 'inherit',]
        let ll = mt[-1:]
        let bc = mt[:-2]
        call lexima#add_rule({
            \ 'char': ll,
            \ 'input_after': '/',
            \ 'at': '^\s*<%'.bc.'\%#',
            \ 'filetype': 'mako',
            \ })
        call lexima#add_rule({
            \ 'char': '<BS>',
            \ 'delete': 1,
            \ 'at': '^\s*<%'.mt.'\%#/>',
            \ 'filetype': 'mako',
            \ })
    endfor

    call lexima#add_rule({
        \ 'char': '<CR>',
        \ 'input': '<CR>',
        \ 'input_after': '<CR>%',
        \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1.*\%>',
        \ 'at': '^\s*<%!*\%#>',
        \ 'filetype': 'mako',
        \ })
    " }}}
endfunction
" vim: fdm=marker
