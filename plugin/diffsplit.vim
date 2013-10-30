" Put this in plugin/diffsplit.vim.
"
" Executing :Diffsplit on a file, containing a git diff would open up a new
" tab, cd to a temporary directory, and distribute the changes into separate
" files, mirroring the repo layout. You can then use NERDTree or whatever you
" like to browse through the changes.
"
" Using it straight from the command-line is fairly simple and ailiasable:
"
"   git diff whatever | vim - -R +Diffsplit
"

command! Diffsplit call s:Diffsplit()
function! s:Diffsplit()
  let files              = {}
  let current_file       = ''
  let file_start_pattern = 'diff --git a/\zs.\+\ze b/'

  for lineno in range(1, line('$'))
    let line = getline(lineno)

    if line =~ file_start_pattern
      let current_file = matchstr(line, file_start_pattern)
      let files[current_file] = []
    else
      call add(files[current_file], line)
    endif
  endfor

  let dir = tempname()
  call mkdir(dir)
  exe 'cd '.dir

  for [filename, lines] in items(files)
    let parent = fnamemodify(filename, ':h')
    if !isdirectory(parent)
      call mkdir(parent, 'p')
    endif

    call writefile(lines, filename . '.diff')
  endfor

  tabnew

  if exists(':NERDTree')
    NERDTree
  endif
endfunction
