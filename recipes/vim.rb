
#package "macvim" do
#    action [:install, :upgrade]
#end

directory "#{node['etc']['passwd'][node['current_user']]['dir']}/.vim/autoload" do
  owner node['current_user']
  mode 00755
  recursive true
  action :create
end

remote_file "#{node['etc']['passwd'][node['current_user']]['dir']}/.vim/autoload/pathogen.vim" do
  source "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
  mode 00755
  action :create_if_missing
end

node['dotfiles']['vim'].each do |folder, repohash|

    directory "#{node['etc']['passwd'][node['current_user']]['dir']}/.vim/#{folder}" do
        owner node['current_user']
	mode 00755
	recursive true
    end

    repohash.each do |repos|
        repos.each do |repo|
            git "#{node['etc']['passwd'][node['current_user']]['dir']}/.vim/#{folder}/#{repo[0]}" do
                repository repo[1]
                enable_submodules true
                action :sync
                user node['current_user']
            end
        end
    end

end

directory "#{node['etc']['passwd'][node['current_user']]['dir']}/.vim/colors" do
  owner node['current_user']
  mode 00755
  recursive true
  action :create
end

remote_file "#{node['etc']['passwd'][node['current_user']]['dir']}/.vim/colors/Tomorrow-Night-Eighties.vim" do
    source "https://raw.github.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Eighties.vim"
    mode 00755
    action :create_if_missing
end

template "#{node['etc']['passwd'][node['current_user']]['dir']}/.vimrc" do
  source "vimrc.erb"
end
