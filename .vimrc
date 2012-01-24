" Set to auto read when a file is changed from the outside
set autoread

"set wildmenu "Turn on WiLd menu

set hid "Change buffer - without saving

set ignorecase "Ignore case when searching
set smartcase

set cursorline
hi CursorLine guibg=#e7ebff
" Pour activer les numéros de lignes dans la marge :
set number

" Pour conserver d'avantages d'historique
set history=1000
" On veut conserver d'avantage de niveaux d'annulation aussi
set undolevels=1000

" Des ficheirs qu'on ne voudra probablement pas éditer
set wildignore=*.swp,*.bak,*.pyc,*.class

" Modification du titre du terminal
set title

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indispensable pour ne pas tout casser avec ce qui va suivre
set preserveindent
" indentation automatique
"set autoindent
" Remplace les tab par des espaces
set expandtab
" largeur auto-indentation
set shiftwidth=4
" Arrondit la valeur de l'indentation
set shiftround
" Largeur du caractère tab
set tabstop=4
" Largeur de l'indentation de la touche tab
set softtabstop=4

" Utilise shiftwidth à la place de tabstop en début de ligne (et backspace
" supprime d'un coup si ce sont des espaces)
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

" autoindent n'est spécifique à aucun langage et fonctionne en général moins
" bien
set noautoindent
filetype on " try to detect filetypes
filetype plugin indent on " enable loading indent file for filetype
filetype indent on

" Afficher en permanence la barre d'état (en plus de la barre de commande) :
"statusline setup
set statusline=%f "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h "help file flag
set statusline+=%y "filetype
set statusline+=%r "read only flag
set statusline+=%m "modified flag

set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%= "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c, "cursor column
set statusline+=%l/%L "cursor line/total lines
set statusline+=\ %P "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

"find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning = '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

"Montre les caractères de fin de lignes, les tabs et les espaces en trop
set list
"set listchars=eol:¤,trail:-
set listchars=tab:»·,trail:-
" On masque cependant les tabulations pour les fichiers XML et HTML, c'est OK
autocmd filetype html,xml set listchars-=tab:>.

set foldmethod=indent
set foldlevel=99

" faire en sorte que le raccourci CTRL-X-F
" marche même quand le fichier est après
" le caractère égal. Comme :
" variable=/etc/<C-XF>
set isfname-==

"chargement de pathogen
call pathogen#infect()

" mmodification du \ pour ,
let mapleader=","

set mouse=a

nmap <silent> ,/ :nohlsearch<CR>

" raccourci fuzzyfinder
nmap ,f :FufFileWithCurrentBufferDir<CR>

" autocommads on php files
set complete=.,w,b,u,t,i,k~/.vim/syntax/php.api
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Create tags with '\1' command
"function! Phptags()
"    "change exclude for your project, here it's a good exclude for Copix temp and var files"
"    let cmd = '!ctags -f .tags -h ".php" -R --exclude="\.svn" --exclude="./var" --exclude="./temp" --totals=yes --tag-relative=yes'
"    exec cmd
"    set tags=.tags
"endfunction
":let g:proj_run1='call Phptags()'
"
""to remap \1 on ,1
"nmap ,1 \1

" lancement de nerdtree avec vim
"autocmd vimenter * NERDTree
" lancement de nerdtree si aucun ficier n'a été spécifié
autocmd vimenter * if !argc() | NERDTree | endif
" fermeture de vim si nerdtree reste seul à gauche
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
