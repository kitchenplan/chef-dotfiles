
## SSH-config
if platform_family?('debian')
    template "/etc/ssh/ssh_config" do
        source "ssh_config.erb"
        owner "root"
        mode "0644"
    end
else
    template "/etc/ssh_config" do
        source "ssh_config.erb"
        owner "root"
        mode "0644"
    end
end
