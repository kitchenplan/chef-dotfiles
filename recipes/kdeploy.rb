include_recipe 'applications::git'

# Getting the kdeploy sources
git "/opt/kDeploy" do
  repository "git@github.com:Kunstmaan/kDeploy.git"
  reference "master"
  action :sync
  user node['current_user']
end

template "/opt/kDeploy/tools/config.xml" do
  source "kdeploy.conf.erb"
  owner "root"
  mode "0755"
  variables(
    :user => node['current_user'],
    :password => node["mysql_root_password"],
    :hostname => node["dotfiles"]["kdeploy"]["hostname"]
  )
end

directory "/home/projects" do
  owner "root"
  group "admin"
  mode 0777
  action :create
  recursive true
end
