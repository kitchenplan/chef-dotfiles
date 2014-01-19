node['dotfiles']['vimusers'].each do |user|
  vimrc_path = "#{node['etc']['passwd'][user]['dir']}/.vimrc"
  vimplugin_prefix = "#{node['etc']['passwd'][user]['dir']}/.vim"

  directory "#{vimplugin_prefix}/autoload" do
    owner user
    mode 00755
    recursive true
    action :create
  end

  remote_file "#{vimplugin_prefix}/autoload/pathogen.vim" do
    source "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
    mode 00755
    owner user
    action :create_if_missing
  end

  node['dotfiles']['vim'].each do |folder, repohash|
    directory "#{vimplugin_prefix}/#{folder}" do
      owner user
      mode 00755
      recursive true
    end
    repohash.each do |repos|
      repos.each do |repo|
        git "#{vimplugin_prefix}/#{folder}/#{repo[0]}" do
          repository repo[1]
          enable_submodules true
          action :sync
          user user
        end
      end
    end
  end

  directory "#{vimplugin_prefix}/colors" do
    owner user
    mode 00755
    recursive true
    action :create
  end

  remote_file "#{vimplugin_prefix}/colors/Tomorrow-Night-Eighties.vim" do
      source "https://raw.github.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Eighties.vim"
      mode 00755
      owner user
      action :create_if_missing
  end

  template vimrc_path do
    source "vimrc.erb"
    owner user
  end
end
