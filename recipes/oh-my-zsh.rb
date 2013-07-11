execute "oh my zsh install" do
  command "curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh"
  user node['current_user']
  not_if { File.exist?("#{node['etc']['passwd'][node['current_user']]['dir']}/.oh-my-zsh") }
end

template "#{node['etc']['passwd'][node['current_user']]['dir']}/.zshrc" do
  source "zshrc.erb"
  cookbook 'dotfiles'
  owner node['current_user']
  mode "0777"
end
