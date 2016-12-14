# allows this to not be called app_node_deploy
resource_name :deploy_nodejs

property :app_name, String, name_property: true
property :app_version, String, required: true
property :dns_name, String, default: "localhost"
property :app_user, String, default: "ubuntu"
property :app_port, Fixnum, default: 3000
property :s3_region, String, default: "#{node['base']['aws']['region']}"
property :s3_bucket, String, default: "#{node['base']['releases_bucket']}"
property :entry_point, String, default: "index.js"
property :tar_flags, Array, default: []
# property :proxy_user, String, default: "www-data"

# TODO: figure out if we want to do this. would make it harder to deploy a
#       "new" copy of the same version (ie I have to bump versions better)
# load_current_value do 
#   set current values from the system to see if things have changed.
# end

action :create do

  artifact_package_name = "#{app_name}-#{app_version}.tar.gz"
  artifact_path = "/tmp/#{artifact_package_name}"
  target_dir = "/opt/#{app_name}"

  awscli_s3_file artifact_path do
    region s3_region
    bucket s3_bucket
    key "#{app_name}/#{artifact_package_name}"
    timeout 1200
    owner app_user
    group app_user
    mode '0644'
  end

  directory target_dir do
    owner app_user
    group app_user
    mode '0744'
    action :create
  end
  puts "&%&%&"
  puts tar_flags
  tar_extract artifact_path do
    target_dir target_dir
    creates "#{target_dir}/#{entry_point}"
    tar_flags tar_flags
    user app_user
    group app_user
    mode '0744'
    action :extract_local
  end

  include_recipe "nodejs"
  include_recipe 'jhg_nginx'

  template "#{node['nginx']['dir']}/sites-available/#{app_name}" do
    source 'app.nginx.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    cookbook 'app_node'
    variables({
      :server_name => "#{dns_name}",
      :app_port => "#{app_port}"  
    })
  end

  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action   :enable
  end

  nginx_site "#{app_name}" do
    enable true
  end

  template "/etc/init/#{app_name}.conf" do
    source 'app.upstart.conf.erb'
    owner 'root'
    group 'root'
    mode '0744'
    cookbook 'app_node'
    variables({
      :app_name => node,
      :app_dir => target_dir
    })
  end

  service "#{app_name}" do
    action [:enable, :start]
  end
end

# TODO: rip all the stuff off the box. logs, code, service, nginx conf, etc
# Q: how could i attempt to safely remove nginx if nothing else installed it? 
# action :delete do
#
# end