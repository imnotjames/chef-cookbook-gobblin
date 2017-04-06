name 'gobblin'
maintainer 'James Ward'
maintainer_email 'james@notjam.es'
license 'MIT'
description 'Installs/Configures gobblin'
long_description 'Installs/Configures gobblin'
version '0.1.0'

issues_url 'https://github.com/imnotjames/chef-cookbook-gobblin/issues' if respond_to?(:issues_url)
source_url 'https://github.com/imnotjames/chef-cookbook-gobblin' if respond_to?(:source_url)

depends 'tar', '~> 2.0.0'
depends 'java', '~> 1.48.0'
depends 'systemd', '~> 2.1.3'
