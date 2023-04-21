" By default, Vim ships with SQLComplete, which requires the dbext plugin to
" work, and otherwise gets really annoying. Since I don't need dbext not SQL
" completion, I just define an empty function to override SQLComplete completely
function! sqlcomplete#Complete(findstart, base)
  " do nothing
endfunction
