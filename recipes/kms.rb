include_recipe 'applications::git'
include_recipe 'dotfiles::bash_it'

directory "/opt" do
  owner "root"
  group value_for_platform(
                            "mac_os_x" => { "default" => "admin" },
                            "default" => "root"
                          )
  mode 0744
  action :create
end

# Getting the kms sources

git "/opt/kms" do
  repository "https://github.com/Kunstmaan/kms.git"
  reference "master"
  action :checkout
  user value_for_platform(
                            "mac_os_x" => { "default" => node['current_user'] },
                            "default" => "root"
                          )
end

# Add to the bash_profile settings
dotfiles_bash_it_custom_plugin "bash_it/custom/kms.bash"
