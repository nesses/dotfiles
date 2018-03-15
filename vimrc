" Directory setup
set directory=~/.vim/swap
set backupdir=~/.vim/backup
set undodir=~/.vim/undo
set viminfofile=~/.vim/viminfo
set undofile

" Feel
set ignorecase

" Look
set tabstop=4
set nowrap
set number
set showtabline=2
set laststatus=2
set cursorline
set statusline=\[%F\]%y\[%L\]

" Keymapping
map t <Esc>:tabnew<CR>
map " :NERDTreeToggle

function CommentBlock(comment,...)
	let marker = a:0 >= 1 ? a:1 : "#"
	let ext = "="
	let width = strlen(a:comment) + 2

	return marker . repeat(ext,width) . "\<CR>"
	\	 . marker . " " . a:comment   . "\<CR>"
	\	 . marker . repeat(ext,width) . "\<CR>"
endfunction

set paste
"map c :%s/^\t*//g<CR>

imap <silent>  ###  <C-R>=CommentBlock(input("Enter comment: "))<CR>
imap <silent>  """  <C-R>=CommentBlock(input("Enter comment: "),'"')<CR>

function! InsertStatuslineColor(mode)
	if a:mode == 'i'
		hi statusline ctermfg=6 ctermbg=0
	elseif a:mode == 'r'
		hi statusline ctermfg=5 ctermbg=0
	elseif a:mode == "v"
		hi statusline ctermfg=1 ctermbg=0
	else
		hi statusline ctermfg=1 ctermbg=0
	endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15


