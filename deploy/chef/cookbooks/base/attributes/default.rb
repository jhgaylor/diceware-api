default['awscli']['version'] = '1.11.23'

default['base']['packages'] = %w{
  libffi-dev
  libssl-dev
  python-dev
  python-pip
  build-essential
}

default['base']['releases_bucket'] = "jhg-sw-releases"
default['base']['aws']['region'] = 'us-west-2'