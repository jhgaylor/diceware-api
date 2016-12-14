deploy_nodejs node['diceware']['name'] do |r|
  app_version node['diceware']['version']
  dns_name node['diceware']['dns_name']
end
