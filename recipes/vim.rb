node['dotfiles']['vimusers'].each do |user|
  homepath = lambda {
    path = "/tmp"
    if node['etc']['passwd'][user]
      path = node['etc']['passwd'][user]['dir']
    end
    path
  }

  directory "#{homepath.call}/.vim/autoload" do
    owner user
    mode 00755
    recursive true
    action :create
  end

  remote_file "#{homepath.call}/.vim/autoload/pathogen.vim" do
    source "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
    mode 00755
    owner user
    action :create_if_missing
  end

  node['dotfiles']['vim'].each do |folder, repohash|
    directory "#{homepath.call}/.vim/#{folder}" do
      owner user
      mode 00755
      recursive true
    end
    repohash.each do |repos|
      repos.each do |repo|
        git "#{homepath.call}/.vim/#{folder}/#{repo[0]}" do
          repository repo[1]
          enable_submodules true
          action :sync
          user user
        end
      end
    end
  end

  directory "#{homepath.call}/.vim/colors" do
    owner user
    mode 00755
    recursive true
    action :create
  end

  remote_file "#{homepath.call}/.vim/colors/Tomorrow-Night-Eighties.vim" do
      source "https://raw.github.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Eighties.vim"
      mode 00755
      owner user
      action :create_if_missing
  end

  template "#{homepath.call}/.vimrc" do
    source "vimrc.erb"
    owner user
  end
end
