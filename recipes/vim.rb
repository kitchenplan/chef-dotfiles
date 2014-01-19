node['dotfiles']['vimusers'].each do |user|
  homepath = lambda { node['etc']['passwd'][user]['dir'] }

  directory "#{homepath}/.vim/autoload" do
    owner user
    mode 00755
    recursive true
    action :create
  end

  remote_file "#{homepath}/.vim/autoload/pathogen.vim" do
    source "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
    mode 00755
    owner user
    action :create_if_missing
  end

  node['dotfiles']['vim'].each do |folder, repohash|
    directory "#{homepath}/.vim/#{folder}" do
      owner user
      mode 00755
      recursive true
    end
    repohash.each do |repos|
      repos.each do |repo|
        git "#{homepath}/.vim/#{folder}/#{repo[0]}" do
          repository repo[1]
          enable_submodules true
          action :sync
          user user
        end
      end
    end
  end

  directory "#{homepath}/.vim/colors" do
    owner user
    mode 00755
    recursive true
    action :create
  end

  remote_file "#{homepath}/.vim/colors/Tomorrow-Night-Eighties.vim" do
      source "https://raw.github.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Eighties.vim"
      mode 00755
      owner user
      action :create_if_missing
  end

  template "#{homepath}/.vimrc" do
    source "vimrc.erb"
    owner user
  end
end
