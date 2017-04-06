include_recipe 'java'

gobblin_package_version = node['gobblin']['version']
gobblin_distribution_url = node['gobblin']['install']['distribution-url']
gobblin_distribution_checksum = node['gobblin']['install']['distribution-checksum']

gobblin_user = node['gobblin']['user']
gobblin_group = node['gobblin']['group']

gobblin_home_dir = node['gobblin']['home-directory']
gobblin_install_dir = node['gobblin']['install-directory']
gobblin_log_dir = node['gobblin']['log-directory']
gobblin_job_config_dir = node['gobblin']['job-directory']

# Create users that own gobblin
user gobblin_user do
  home gobblin_home_dir
end

group gobblin_group do
  members [ gobblin_user ]
end

# Create Directories
directory gobblin_log_dir do
  owner gobblin_user
  group gobblin_group
  mode '0750'
  action :create
end

directory gobblin_job_config_dir do
  owner gobblin_user
  group gobblin_group
  mode '0550'
  recursive true
  action :create
end

directory "#{gobblin_install_dir}/#{gobblin_package_version}" do
  owner gobblin_user
  group gobblin_group
  mode '0555'
  recursive true
  action :create
end

# Extract the distribution tarfile to the installation directory
tar_extract gobblin_distribution_url do
  checksum gobblin_distribution_checksum
  target_dir "#{gobblin_install_dir}/#{gobblin_package_version}"
  creates "#{gobblin_install_dir}/#{gobblin_package_version}/bin/gobblin"
  tar_flags [ '-P', '--strip-components 1' ]
end
