deploy_static node['pathfinder']['ui']['name'] do |r|
  app_version node['pathfinder']['ui']['version']
  dns_name node['pathfinder']['ui']['dns_name']
end
