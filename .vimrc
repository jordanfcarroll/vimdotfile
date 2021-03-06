" Plugin Manager - vim-plug
"   https://github.com/junegunn/vim-plug


" Options for Opening in diff mode
if &diff
    " Colorscheme & font
    call plug#begin('~/.vim/plugged')

    Plug 'morhetz/gruvbox'
    " Initialize plugin system
    call plug#end()

    " Theme and Font
    colorscheme gruvbox
    if has('gui_running')
    set guifont=CascadiaCode-Regular:h11
    endif
    set background=dark

else
    " Working Directory -----------
    cd 
    """ -------------------------

    let mapleader = " "

    " Specify a directory for plugins
    call plug#begin('~/.vim/plugged')

        " Intellisense Engine
        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        " Git Gutter
        Plug 'airblade/vim-gitgutter'

        " Fuzzy find
        Plug 'ctrlpvim/ctrlp.vim'

        " neat status bar
        Plug 'vim-airline/vim-airline'

        " Surround motions
        Plug 'tpope/vim-surround'

        " Vue syntax highlighting
        Plug 'posva/vim-vue'

        " Vue pug syntax highlighting
        Plug 'digitaltoad/vim-pug'
        
        " More Intuitive netwr
        Plug 'tpope/vim-vinegar'

        " Git Integration
        Plug 'tpope/vim-fugitive'

        " Indent Guide Color Gradation
        Plug 'nathanaelkane/vim-indent-guides'

        " Commenting (Works properly with embedded syntax)
        Plug 'tomtom/tcomment_vim' 

        " Better navigation between split panes
        Plug 'christoomey/vim-tmux-navigator'

        " TS syntax highlighing
        " Plug 'HerringtonDarkholme/yats.vim'

        " Themes
        Plug 'morhetz/gruvbox'
        Plug 'franbach/miramare'
        Plug 'phanviet/vim-monokai-pro'


    " Initialize plugin system
    call plug#end()
    filetype plugin on



    " TESTING 
    filetype plugin indent on

    " ctrl p speed
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
    if executable('ag')
      let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    endif


    " Truncate airline sections based on window width
    let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 200,
      \ }


    " END TESTING
    

    " Files with unsaved changes will be hidden instead of closed on file change, meaning no prompt to
    " save each time
    set hidden 

    " Don't beep
    set visualbell           
    set noerrorbells    

    " Save a lot so a swap file is more trouble than worth
    set nobackup
    set noswapfile

    " Make sure vim writes after you edit a newly created file,
    " instead of waiting for save
     :autocmd BufNewFile * :write

    " Max number of columns for syntax highlighting (higher values slow vim
    " down??)
    set synmaxcol=1000  

    " Allow exiting insert mode with jk
    inoremap jk <ESC>

    " Indenting
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1

    " ctrlp
    let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
    let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|mockup'

    " vim-vue
    " Manually specifying needed syntax preprocessers gets rid of the slowness
    let g:vue_pre_processors = 'detect_on_enter'

    " j/k will move virtual lines (lines that wrap)
    noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
    noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
    nnoremap H gT
    nnoremap L gt



    " WINDOW SPLITS
    
    " Remap Window splitting commands
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>
    " More natural splitting than default
    set splitbelow
    set splitright

    " Filename, etc will display at bottom of split windows
    " [buffer number] followed by filename:
    set statusline=[%n]\ %t
    " show line#:column# on the right hand side
    set statusline+=%=%l:%c


    " line number display
    set relativenumber number

    " Treat hyphens as part of words
    set iskeyword+=-

    set smarttab
    set cindent

    " Tab length
    set tabstop=2
    set shiftwidth=2
    " always uses spaces instead of tab characters
    set expandtab

    " highlight search results
    set hlsearch
    set incsearch

    set ignorecase
    set smartcase
    set scrolloff=20


    " FOLDING

    " folding
    if has('folding')
      if has('windows')
        set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 92 83)
      endif
      set foldmethod=indent               " not as cool as syntax, but faster
      set foldlevelstart=99               " start unfolded
    endif

    " tab will open single fold
    nnoremap <tab> za


    " COLORSCHEME & FONT

    " Theme and Font
    set background=dark
    colorscheme gruvbox
    if has('gui_running')
        set guifont=CascadiaCode-Regular:h11
    endif
    " set background=dark


    " leader leader jumps to previous file
    nnoremap <Leader><Leader> <C-^>


    " COC - Language servers and autocomplete
    let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-vetur',
      \ 'coc-eslint', 
      \ 'coc-prettier', 
      \ 'coc-json', 
      \ ]

    " from coc repo 
    "
    " Better display for messages 
    set cmdheight=2 " You will have bad experience for diagnostic messages when it's default n000.
    set updatetime=300

    " don't give |ins-completion-menu| messages.
    set shortmess+=c

    " always show signcolumns
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <F2> <Plug>(coc-rename)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
endif

