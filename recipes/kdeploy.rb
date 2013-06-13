include_recipe 'applications::git'

if platform_family?('debian')
    ## Need fix for OSX
    include_recipe "root_ssh_agent::env_keep"
    include_recipe "root_ssh_agent::ppid"
end

if platform?('mac_os_x')
    include_recipe 'osxdefaults::finder_unhide_home'
elsif platform_family?('debian')
    include_recipe 'applications::essentials'
end

#Getting the kdeploy sources
git "/opt/kDeploy" do
    repository "git@github.com:Kunstmaan/kDeploy.git"
    reference "master"
    action :sync
    user node['current_user']
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
  mode "0777"
  action :create
  recursive true
end

#Create the backupped-projects directory
directory "/home/backupped-projects" do
  owner "root"
  group "admin"
  mode "0777"
  action :create
  recursive true
end

#Include recipes for required packages
include_recipe 'applications::postgresql'
include_recipe 'applications::psycopg2'
include_recipe 'applications::mysql'
include_recipe 'applications::mysql_python'
include_recipe 'applications::apache'
include_recipe 'applications::php54'

#Packages required for the debian family
if platform_family?('debian')
    include_recipe 'applications::mysql_workbench'
#    include_recipe 'applications::acl'
    include_recipe 'applications::server_tuning'
    include_recipe 'applications::postfix'
    include_recipe 'applications::java'
end

#Create the dir /opt/jdk and the symlink default to the java
if platform_family?('debian')
    directory "/opt/jdk" do
        owner "root"
        group "root"
        mode 0755
        action :create
    end

    link "/opt/jdk/default" do
        to "/usr/lib/jvm/java-6-openjdk-amd64"
        not_if "test -L /opt/jdk/default"
    end
end

#Only the servers need newrelic and Varnish
unless Chef::Config[:solo]
    include_recipe 'applications::varnish'
    include_recipe 'applications::newrelic'
end

if platform_family?('debian')
    #Configure tomcat
    directory "/etc/tomcat" do
        owner "root"
        group "root"
        mode "0755"
        action :create
        recursive true
    end
    template "/etc/tomcat/setenv.sh" do
        source "tomcat_setenv.sh.erb"
        owner "root"
        mode "0644"
    end
end

#Configure the hupapache and logrotate
script "configure hupapache" do
    interpreter "bash"
    cwd "/opt/kDeploy/tools"
    code <<-EOH
        gcc -o hupapache hupapache.c
        chmod u+s hupapache
    EOH
end
script "configure logrotate" do
    interpreter "bash"
    cwd "/opt/kDeploy/tools"
    code <<-EOH
        gcc -o logrotate logrotate.c
        chmod u+s logrotate
    EOH
end
