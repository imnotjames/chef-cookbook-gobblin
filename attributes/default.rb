default['java']['jdk_version'] = '8'

default['gobblin']['version'] = '0.9.0'

default['gobblin']['install-directory'] = '/opt/gobblin'
default['gobblin']['log-directory'] = '/var/log/gobblin'
default['gobblin']['job-directory'] = '/etc/gobblin/jobs'

default['gobblin']['user'] = 'gobblin'
default['gobblin']['group'] = 'gobblin'
default['gobblin']['home-directory'] = '/home/gobblin'

default['gobblin']['install']['distribution-url'] = "https://github.com/linkedin/gobblin/releases/download/gobblin_#{node['gobblin']['version']}/gobblin-distribution-#{node['gobblin']['version']}.tar.gz"
default['gobblin']['intstall']['distribution-checksum'] = 'b1b236e5409ff10810daf310664fd0667cc358cd2937c7ff68e0845dd8fa182a'
