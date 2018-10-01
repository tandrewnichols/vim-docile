function! docile#createCommands() abort
  hi ColorColumn ctermbg=red
  command! -buffer -nargs=0 DocileToggle call docile#help#toggleFiletype()
  command! -buffer -nargs=0 DocileHelpGuide call docile#help#toggleGuide()
  command! -buffer -nargs=0 DocileFormatParagraph call docile#help#realign()
  command! -buffer -nargs=+ DocileAddHeader call docile#help#addHeader(<f-args>)
  command! -buffer -nargs=+ DocileAddRef call docile#help#addRef(<f-args>)

  call docile#map('toggle_mapping', ':call docile#help#toggleFiletype()<CR>')
  call docile#map('help_guide_mapping', ':call docile#help#toggleGuide()<CR>')
  call docile#map('format_mapping', ':call docile#help#realign()<CR>')
  call docile#map('add_header_mapping', ':DocileAddHeader ')
  call docile#map('add_ref_mapping', ':DocileAddRef ')
endfunction

function! docile#map(lhs, rhs) abort
  let lhs = a:lhs
  let rhs = a:rhs
  if !empty(get(g:, "docile_" . lhs))
    exec "nnoremap <buffer>" get(g:, "docile_" . lhs) rhs
  endif
endfunction
