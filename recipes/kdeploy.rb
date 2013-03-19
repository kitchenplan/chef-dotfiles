include_recipe 'applications::git'
if platform?('mac_os_x')
    include_recipe 'osxdefaults::finder_unhide_home'
elsif platform_family?('debian')
    include_recipe 'applications::essentials'
end

# Getting the kdeploy sources and place the correct values in the config.xml
git "/opt/kDeploy" do
  repository "git@github.com:Kunstmaan/kDeploy.git"
  reference "master"
  action :sync
  user node["current_user"]
end

#set the correct parameters to use in the config.xml
if Chef::Config[:solo]
    hostname = node["dotfiles"]["kdeploy"]["hostname"] + ".kunstmaan.be"
    if platform?('mac_os_x')
        postgresuser = node['current_user']
    elsif platform_family?('debian')
        postgresuser = "postgres"
    end
else
    hostname = node["dotfiles"]["kdeploy"]["hostname"] + ".kunstmaan.com"
    postgresuser = "postgres"
end

#Set the config.xml file with the correct parameters
template "/opt/kDeploy/tools/config.xml" do
  source "kdeploy.conf.erb"
  owner "root"
  mode "0755"
  variables(
    :user => postgresuser,
    :password => node["mysql_root_password"],
    :hostname => hostname
  )
end

#Create the project directory
directory "/home/projects" do
  owner "root"
  group "admin"
  mode 0777
  action :create
  recursive true
end

#Create the backupped-projects directory
directory "/home/backupped-projects" do
  owner "root"
  group "admin"
  mode 0777
  action :create
  recursive true
end
