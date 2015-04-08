node['dotfiles']['vimusers'].each do |username|

  unless node['etc']['passwd'][username]
    username = "travis"
  end

  homepath = lambda {
    path = "/tmp"
    if node['etc']['passwd'][username]
      path = node['etc']['passwd'][username]['dir']
    end
    path
  }

  directory "#{homepath.call}/.vim/autoload" do
    owner username
    mode 00755
    recursive true
    action :create
  end

  remote_file "#{homepath.call}/.vim/autoload/pathogen.vim" do
    source "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
    mode 00755
    owner username
    action :create_if_missing
  end

  directory "#{homepath.call}/.vim/bundle" do
    owner username
    mode 00755
    recursive true
  end

  node['dotfiles']['vim']['bundle'].each do |bundles|
    bundles.each do |name, uri|
      git "#{homepath.call}/.vim/bundle/#{name}" do
        repository uri
        enable_submodules true
        enable_checkout false
        action :sync
        user username
      end
    end
  end

  directory "#{homepath.call}/.vim/colors" do
    owner username
    mode 00755
    recursive true
    action :create
  end

  node['dotfiles']['vim']['colors'].each do |colors|
    colors.each do |name, uri|
      remote_file "#{homepath.call}/.vim/colors/#{name}.vim" do
        source uri
        mode 00644
        owner username
        action :create_if_missing
      end
    end
  end

  template "#{homepath.call}/.vimrc" do
    source "vimrc.erb"
    owner username
    variables(
      'background' => node['dotfiles']['vim']['vimrc']['background'],
      'colorscheme' => node['dotfiles']['vim']['vimrc']['colorscheme']
    )
  end
end
