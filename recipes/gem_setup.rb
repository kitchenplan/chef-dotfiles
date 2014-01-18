dotfiles_bash_it_custom_plugin "gem_setup-warn_on_sudo.bash"

thegroup = value_for_platform(
    ["mac_os_x"] => { "default" => "wheel"},
    "default" => "root"
)

file "/etc/gemrc" do
  owner "root"
  group thegroup
  mode "0644"
  action :create
  content "install: --no-rdoc --no-ri\nupdate: --no-rdoc --no-ri\n"
end

link "#{node['current_user']['dir']}/.gemrc" do
  to "/etc/gemrc"
  owner node['current_user']
end
