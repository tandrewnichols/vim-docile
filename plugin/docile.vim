if exists("g:loaded_docile") || &cp | finish | endif

let g:loaded_docile = 1

let g:docile_VERSION = '1.0.0'

function! s:Set(option, default) abort
  exec "let g:docile_" . a:option "= get(g:, 'docile_" . a:option . "', a:default)"
endfunction

" Set some defaults
for [option, default] in items({
  \   'toggle_mapping': "dot",
  \   'help_guide_mapping': "dog",
  \   'format_mapping': "do=",
  \   'add_header': "doh",
  \   'add_ref': "dor"
  \   'add_header_mapping': 'doh',
  \   'add_ref_mapping': 'dor'
  \ })
  call s:Set(option, default)
endfor
