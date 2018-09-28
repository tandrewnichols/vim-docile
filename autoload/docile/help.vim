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
  if line =~ '\s\+'
    let num = matchstrpos(line, '[^ ]\+\s\+\zs[^\s]')
    normal! j
    exec "normal!" num[1] . "i "

    while len(getline('.')) > 80
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

function! docile#help#addHeader(...) abort
  let args = a:000
  if len(args) == 1
    let header = toupper(args[0])
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
  let num = 49 - len(a:str)
  return a:str . repeat(' ', num)
endfunction

function! docile#help#makeRef(ref) abort
  let ref = join([docile#help#prefix(), a:ref], '-')
  return join(["*", ref, "*"], '')
endfunction

function! docile#help#prefix() abort
  return expand("%:t:r")
endfunction
