gobblin_package_version = node['gobblin']['version']

gobblin_user = node['gobblin']['user']
gobblin_group = node['gobblin']['group']

gobblin_install_dir = node['gobblin']['install-directory']
gobblin_log_dir = node['gobblin']['log-directory']
gobblin_job_config_dir = node['gobblin']['job-directory']

gobblin_heap_minimum = node['gobblin']['standalone']['heap-minimum']
gobblin_heap_maximum = node['gobblin']['standalone']['heap-maximum']

gobblin_home_dir = node['gobblin']['home-directory']
gobblin_work_dir = node['gobblin']['standalone']['work-directory']
gobblin_config_dir = node['gobblin']['standalone']['config-directory']

gobblin_service_name = 'gobblin-standalone'

gobblin_version_dir = "#{gobblin_install_dir}/#{gobblin_package_version}"
gobblin_lib_dir = "#{gobblin_version_dir}/lib"
gobblin_bin_dir = "#{gobblin_version_dir}/bin"
gobblin_class_path = "#{gobblin_job_config_dir}/*:#{gobblin_lib_dir}/*"

# Create the needed directories
directory gobblin_config_dir do
  owner gobblin_user
  group gobblin_group
  mode '0550'
  recursive true
  action :create
end

# Create the configuration files for the standalone
template "#{gobblin_config_dir}/gobblin.properties" do
  source 'standalone.gobblin.properties.erb'
  owner gobblin_user
  group gobblin_group
  mode 00400
  variables ({
    :gobblin_job_config_dir => gobblin_job_config_dir,
    :gobblin_work_dir => gobblin_work_dir
  })

  notifies :restart, "service[#{gobblin_service_name}]", :delayed
end

template "#{gobblin_config_dir}/log4j.xml" do
  source 'standalone.log4j.xml.erb'
  owner gobblin_user
  group gobblin_group
  mode 00400
  variables ({
    :gobblin_job_config_dir => gobblin_job_config_dir,
    :gobblin_work_dir => gobblin_work_dir
  })

  notifies :restart, "service[#{gobblin_service_name}]", :delayed
end

template "#{gobblin_config_dir}/quartz.properties" do
  source 'standalone.quartz.properties.erb'
  owner gobblin_user
  group gobblin_group
  mode 00400

  notifies :restart, "service[#{gobblin_service_name}]", :delayed
end

# Set up the service we need and enable it
jvm_options = "-Xms#{gobblin_heap_minimum} " \
              "-Xmx#{gobblin_heap_maximum} "\
              "-XX:+UseConcMarkSweepGC "\
              "-XX:+UseParNewGC "\
              "-XX:+PrintGCDetails "\
              "-XX:+PrintGCDateStamps "\
              "-XX:+PrintTenuringDistribution "\
              "-XX:+UseCompressedOops "\
              "-XX:+HeapDumpOnOutOfMemoryError "\
              "-XX:HeapDumpPath=#{gobblin_log_dir} "\
              "-Xloggc:#{gobblin_log_dir}/gobblin-gc.log "\
              "-Dgobblin.logs.dir=#{gobblin_log_dir} "\
              "-Dlog4j.configuration=file://#{gobblin_config_dir}/log4j.xml "\
              "-Dorg.quartz.properties=#{gobblin_config_dir}/quartz.properties "\

systemd_service gobblin_service_name do
  description 'Gobblin Standalone Service'
  after %w( local-fs.target network.target )

  install do
    wanted_by 'multi-user.target'
  end

  service do
    exec_start "/usr/bin/java #{jvm_options} -cp \"#{gobblin_class_path}\" gobblin.scheduler.SchedulerDaemon #{gobblin_config_dir}/gobblin.properties"
    restart 'always'

    working_directory "#{gobblin_work_dir}"
    user gobblin_user
    group gobblin_group
  end
end

service gobblin_service_name do
  action [:enable, :start]
end
