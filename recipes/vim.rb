#package "macvim" do
#    action [:install, :upgrade]
#end

package "vim"

vimrc_path = node["platform"] == "ubuntu" ? "/usr/share/vim/vimrc" : "#{node['etc']['passwd'][node['current_user']]['dir']}/.vimrc"
vimplugin_prefix = node["platform"] == "ubuntu" ? "/usr/share/vim/vimfiles" : "#{node['etc']['passwd'][node['current_user']]['dir']}/.vim"

directory "#{vimplugin_prefix}/autoload" do
  owner node['current_user']
  mode 00755
  recursive true
  action :create
end

remote_file "#{vimplugin_prefix}/autoload/pathogen.vim" do
  source "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
  mode 00755
  action :create_if_missing
end

node['dotfiles']['vim'].each do |folder, repohash|

    directory "#{vimplugin_prefix}/#{folder}" do
        owner node['current_user']
	mode 00755
	recursive true
    end

    repohash.each do |repos|
        repos.each do |repo|
            git "#{vimplugin_prefix}/#{folder}/#{repo[0]}" do
                repository repo[1]
                enable_submodules true
                action :sync
                user node['current_user']
            end
        end
    end

end

directory "#{vimplugin_prefix}/colors" do
  owner node['current_user']
  mode 00755
  recursive true
  action :create
end

remote_file "#{vimplugin_prefix}/colors/Tomorrow-Night-Eighties.vim" do
    source "https://raw.github.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Eighties.vim"
    mode 00755
    action :create_if_missing
end

template vimrc_path do
  source "vimrc.erb"
end
