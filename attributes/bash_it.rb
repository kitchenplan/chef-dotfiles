node.default['bash_it'] ={
  'enabled_plugins' => {
    'aliases'    => %w[ansible bundler general git heroku homebrew osx vagrant vim laravel],
    'completion' => %w[bash-it brew capistrano defaults gem gh git git_flow grunt gulp packer pip rake ssh tmux vagrant virtualbox],
    'plugins'    => %w[base git rvm ssh vagrant extract node nvm osx ruby]
  },
  'custom_plugins' => {
      "dotfiles" => %w[
        bash_it/custom/ensure_usr_local_bin_first.bash
        bash_it/custom/aliases.bash
        bash_it/custom/base.bash
        bash_it/custom/exports.bash
        bash_it/custom/functions.bash
        bash_it/custom/skylab.completion.bash
      ]
  },
  'theme' => 'roderik',
  'dir' => '/etc/bash_it',
  'repository' => 'https://github.com/revans/bash-it.git'
}

if node["platform"] == "ubuntu"
    node.default["bash_it"]["bashrc_path"]="/etc/bash.bashrc"
else
    node.default["bash_it"]["bashrc_path"]="/etc/bashrc"
end
