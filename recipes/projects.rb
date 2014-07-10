directory "#{node['etc']['passwd'][node['current_user']]['dir']}/#{node['dotfiles']['project_dir']}" do
    owner node['current_user']
end

node['dotfiles']['projects'].each do |folder, repo|

    directory "#{node['etc']['passwd'][node['current_user']]['dir']}/#{node['dotfiles']['project_dir']}/#{folder}" do
        owner node['current_user']
    end

    git "#{node['etc']['passwd'][node['current_user']]['dir']}/#{node['dotfiles']['project_dir']}/#{folder}" do
        repository repo
        enable_submodules true
        enable_checkout false
        action :checkout
        user node['current_user']
    end
end
