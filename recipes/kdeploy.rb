if platform?('mac_os_x')
    include_recipe "osxdefaults::finder_unhide_home"
end

ssh_known_hosts "github.com" do
  hashed true
  user node['current_user']
end

unless node['current_user'] == "travis"
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
end

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
