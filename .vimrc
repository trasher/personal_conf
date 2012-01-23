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
set laststatus=2

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
