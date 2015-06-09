
template "/etc/bashrc" do
    source "bashrc.erb"
    owner "root"
    mode "0755"
end
