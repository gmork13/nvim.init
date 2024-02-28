" Esc to get out of terminal
" F5 to return to netrw
" ctri p to paste to terminal
" space-y to copy file path 
let mapleader = "\<Space>"
tnoremap <ESC> <C-\><C-n>
nnoremap <leader><Backspace> :e %:h<CR>
nnoremap <F5>                :e %:h<CR>
nnoremap <leader>y :let @+ = expand('%:p')<CR>

for mode in ['n', 'v', 'i']
	if mode == 'i'
		execute mode . 'noremap <Up> <C-o>gk'
		execute mode . 'noremap <Down> <C-o>gj'
	else
		execute mode . 'noremap <Up> gk'
		execute mode . 'noremap <Down> gj'
	endif
endfor

set termguicolors 
set number 
set smartindent 
set tabstop=4
set shiftwidth=4
set ignorecase 
set smartcase 
set wildmenu 
set mouse=a 
set clipboard=unnamedplus 
set fileencoding=utf-8

function! RefreshDisplay()
	let l:display = system("tmux show-environment | grep '^DISPLAY'") [8:]
	let l:clean_display = substitute(l:display, '\n','', 'g')
	let $DISPLAY = l:clean_display
endfunction

command! RefreshDisplay call RefreshDisplay()


nnoremap <leader>b : Buffers <CR> 
nnoremap <leader>ff :lcd %:p:h<CR> :Files <CR>
nnoremap <leader>fF :lcd <CR> :Files <CR>
nnoremap <leader>fs :lcd %:p:h<CR> :Rg <CR>
nnoremap <leader>fS :lcd <CR> :Rg <CR>



nnoremap <leader>q :bn <CR>:bd # <CR>
nnoremap <leader>Q :bn <CR>:bd! # <CR>
nnoremap <leader><Tab> :b! # <CR>


init
nnoremap <leader>' :call ToggleComment () <CR>


function! ToggleComment()
	let l:line = getline('.')
	if l:line =~ '^#'
		call setline('.', substitute(l:line, '^#', '', ''))
	else
		call setline('', '#' . l:line)
	endif
endfunction


function! ToggleCommentLine(line)
	return a:line =~ '^#' ? substitute(a:line, '^#', '', '') : '#' . a:line
endfunction


function! ToggleCommentVisual()
	let l:start = line("'<")
	let l:end   = line("'>")
	let l:shouldComment = getline(l:start) !~ '^#'

	for l:num in range(l:start, l:end)
		let l:line = getline(l:num)
		let l:new_line = ToggleCommentLine(l:line)
		call setline(l:num, l:new_line)
	endfor
endfunction


" DAP key mappings using leader
" SHOULD BE NNOREMAP, not NOREMAP
" noremap ‹leader>db :lua require' dap'. toggle_breakpoint ( )<CR>
" noremap ‹leader>dB :lua require' dap'
" • set_breakpoint (vim. fn. input( 'breakpoint
" condition: ') )<CR›
" noremap < leader>< Right› :lua require 'dap'. continue () <CR>
" < leader>‹Up> :lua require' dap'. step_over () ‹CR> < leader><Down> :lua require'dap'.step_into()<CR>
" < leader›‹Left› :lua require 'dap'. step_out ()‹CR>
" ‹ leader>o :lua require 'dapui'.open () <CR>
" ‹leader>O :lua require' dap'. close ( )<CR>
" ‹ leader›do :lua require' dap' .disconnect); require' dap'. close() ‹CR› ‹ leader›n :lua require' dap' •goto_next () ‹CR>
" noremap < leader>N :lua require 'dap' •goto_prev()‹CR>
"  
" noremap ‹ leader›1 :lua require'dap'.set_breakpoint (nil, nil, vim. fn. input( 'Log point message: ')) <CR>
" noremap < leader›dr :lua require 'dap'. restart () ‹CR›



augroup NetrwSettings
	autocmd!
	autocmd FileType netrw map <buffer> <Backspace> -
	autocmd FileType netrw nnoremap <buffer> <leader>Y :let @+ = expand('%')
	autocmd FileType netrw nnoremap <buffer> <leader>y :let @+ = expand ('%').'/'.expand('<cfile>')<CR>
  	autocmd FileType netrw let g:netrw_liststyle = 3
augroup END


call plug#begin('/home/username/.local/share/nvim/plugged')
" Plug ' ~/git/nvim-dap'
" Plug '~/git/nvim-dap-ui'
" Plug '~/git/nvim-dap-virtual-text'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
call plug#end()



" lua <<EOF
" require 'nvim-treesitter.configs' .setup {
" highlight = 1
" enable = true,
" additional_vim_regex_highlighting = false,
" ｝，
" }
" EOF
"

autocmd FileType json setlocal foldmethod=syntax

" let g: dap_python _executable = 'python3'
" colorscheme onedark
" plug '~/git/ff' {'do': ':install'}?
" Plug
" nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" plug should be above, virtual text should be below inside lua
" Plug
" '~/git/vim-gutentags'
" require ("nvim-dap-virtual-text").setup()
" lua << EOF
" local dap = require( 'dap')
" require ("dapui"). setup ()
"  
"  
" dap. adapters. python = 1
" type = 'executable';
" command = vim. fn.expand (vim.g dap_python_executable);
" args = { '-m', 'debugpy. adapter' };
"  
" dap. configurations. python = 1
" type = 'python';
" request = 'launch';
" name = "Launch file";
" program = "${file}";
" pythonPath = vim. fn. exepath( 'python3');
" console = ' integratedTerminal';
" ｝
" EOF.
