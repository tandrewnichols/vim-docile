function! docile#help#toggleFiletype() abort
  if &ft == "help"
    setlocal nomodeline
    setf text
  elseif &ft == "text"
    setlocal modeline
    setf help
  endif
endfunction

function! docile#help#realign() abort
  let pos = getpos('.')
  normal! {j
  let line = getline('.')

  " If the 'paragraph' contains standalone right justified
  " help reference, ignore that line.
  if line !~ '[^ ]\+\s\+[^ ]'
    normal! j
    let line = getline('.')
  endif

  if line =~ '\s\+'
    let num = matchstrpos(line, '[^ ]\+\s\+\zs[^\s]')
    normal! j
    exec "normal!" num[1] . "i "

    let formatline = substitute(getline('.'), '^\s\+', '', '')

    while len(formatline) > 80
      normal! gq$J
    endwhile

    normal! o
  endif
endfunction

function! docile#help#toggleGuide() abort
  if empty(&colorcolumn)
    setlocal colorcolumn=80
  else
    setlocal colorcolumn=
  endif
endfunction

function! docile#help#addHeader(bang, ...) abort
  let args = a:000
  if len(args) == 1
    let header = a:bang ? toupper(args[0]) : args[0]
    let ref = tolower(args[0])
  else
    let header = toupper(args[0])
    let ref = tolower(args[1])
  endif

  exec "normal! i" . docile#help#pad(header) . docile#help#makeRef(ref)
  normal! o
  startinsert
endfunction

function! docile#help#addRef(...) abort
  let args = a:000

  for arg in args
    exec "normal! i" . docile#help#pad('') . docile#help#makeRef(arg)
    normal! o
  endfor

  startinsert
endfunction

function! docile#help#pad(str) abort
  let num = g:docile_ref_column - 1 - len(a:str)
  return a:str . repeat(' ', num)
endfunction

function! docile#help#makeRef(ref) abort
  if empty(g:docile_use_plugin_refs)
    let ref = a:ref
  else
    let ref = join([docile#help#prefix(), a:ref], '-')
  endif

  return join(["*", ref, "*"], '')
endfunction

function! docile#help#prefix() abort
  return expand("%:t:r")
endfunction
