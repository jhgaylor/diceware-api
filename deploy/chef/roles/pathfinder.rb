name          "pathfinder"
description   "A combined install of pathfinder::ui and pathfinder::api"
run_list      ["recipe[base]", "recipe[pathfinder]"]
default_attributes(
  # "apache2" => { "listen_ports" => [ "80", "443" ] }
)