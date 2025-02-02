let s:suite = themis#suite('toggle')
let s:assert = themis#helper('assert')

function! s:suite.before_each()
  let g:lightline = {}
  call lightline#init()
  tabnew
  tabonly
endfunction

function! s:suite.default()
  call s:assert.equals(exists('#lightline'), 1)
  call s:assert.equals(exists('#lightline-disable'), 0)
  call s:assert.not_equals(&statusline, '')
  call s:assert.not_equals(&tabline, '')
endfunction

function! s:suite.disable_enable()
  call lightline#disable()
  call s:assert.equals(exists('#lightline'), 0)
  call s:assert.equals(exists('#lightline-disable'), 1)
  call s:assert.equals(&statusline, '')
  call s:assert.equals(&tabline, '')
  call lightline#update()
  call s:assert.equals(&statusline, '')
  call s:assert.equals(&tabline, '')
  call lightline#enable()
  call s:assert.equals(exists('#lightline'), 1)
  call s:assert.equals(exists('#lightline-disable'), 0)
  call s:assert.not_equals(&statusline, '')
  call s:assert.not_equals(&tabline, '')
  call lightline#disable()
  call lightline#disable()
  call lightline#enable()
  call lightline#enable()
  call s:assert.equals(exists('#lightline'), 1)
  call s:assert.equals(exists('#lightline-disable'), 0)
endfunction

function! s:suite.toggle()
  call lightline#toggle()
  call s:assert.equals(exists('#lightline'), 0)
  call s:assert.equals(exists('#lightline-disable'), 1)
  call s:assert.equals(&statusline, '')
  call s:assert.equals(&tabline, '')
  call lightline#toggle()
  call s:assert.equals(exists('#lightline'), 1)
  call s:assert.equals(exists('#lightline-disable'), 0)
  call s:assert.not_equals(&statusline, '')
  call s:assert.not_equals(&tabline, '')
endfunction

function! s:suite.notab_toggle()
  let g:lightline = { 'enable': { 'tabline': 0 } }
  call lightline#init()
  call lightline#toggle()
  set tabline=ASDF
  call lightline#toggle()
  let check_tabline = &tabline
  set tabline=
  call s:assert.equals(check_tabline, 'ASDF')
endfunction

