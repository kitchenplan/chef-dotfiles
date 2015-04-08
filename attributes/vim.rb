node.default['dotfiles']['vimusers'] = [node['current_user']]

node.default["dotfiles"]["vim"]["bundle"] = [
  {"sleuth" => "git://github.com/tpope/vim-sleuth.git"},
  {"sensible" => "git://github.com/tpope/vim-sensible.git"},
  {"gitgutter" => "git://github.com/airblade/vim-gitgutter.git"},
  {"airline" => "https://github.com/bling/vim-airline"},
  {"syntastic" => "git://github.com/scrooloose/syntastic.git"},
  {"nerdtree" => "https://github.com/scrooloose/nerdtree.git"}
]

node.default["dotfiles"]["vim"]["colors"] = [
  {"Tomorrow-Night-Eighties" => "https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Eighties.vim"},
  {"base16-ocean" => "https://raw.githubusercontent.com/chriskempson/base16-vim/master/colors/base16-ocean.vim"},
  {"solarized" => "https://raw.githubusercontent.com/altercation/solarized/master/vim-colors-solarized/colors/solarized.vim"}
]

node.default["dotfiles"]["vim"]["vimrc"]["colorscheme"] = "Tomorrow-Night-Eighties"
