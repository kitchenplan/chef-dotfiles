node.default['dotfiles']['vimusers'] = [node['current_user'], 'root']

node.default["dotfiles"]["vim"]["bundle"] = [
  {"sleuth" => "git://github.com/tpope/vim-sleuth.git"},
  {"sensible" => "git://github.com/tpope/vim-sensible.git"},
  {"gitgutter" => "git://github.com/airblade/vim-gitgutter.git"},
  {"airline" => "https://github.com/bling/vim-airline"},
  {"syntastic" => "git://github.com/scrooloose/syntastic.git"},
  {"nerdtree" => "https://github.com/scrooloose/nerdtree.git"}
]
