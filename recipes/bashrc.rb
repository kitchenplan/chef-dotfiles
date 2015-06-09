
template "/etc/bashrc" do
    source "bashrc.erb"
    owner "root"
    mode "0755"
end


template "/etc/lscolors" do
    source "lscolors.erb"
    owner "root"
    mode "0755"
end
