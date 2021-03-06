#
# Cookbook:: sftp_proxy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'openssh'
include_recipe 'firewalld'
include_recipe 'selinux_policy::install'

# Create directory tree under /opt/bb
directory '/opt/bb/etc/sftp-ng' do
   owner 'ftppxyadmin'
   group 'ftppxyadmin'
   mode '0755'
   recursive true
   action :create
end

# Create systemd environment file for SFTP-dedicated sshd
template '/opt/bb/etc/sshd_env' do
   source 'sshd_env.erb'
   mode '0640'
   owner 'root'
   group 'root'
   variables({
      env_options: node['environment']['options'],
      })
end

# Create custom configuration for SFTP-dedicated sshd
template '/opt/bb/etc/sftp-ng/sshd_config' do
   source 'sshd_config.erb'
   mode '0440'
   owner 'root'
   group 'root'
   variables({
      listen_address: node['network']['address'],
      listen_port:    node['network']['port']
      })
end

firewalld_port '2245/tcp' do
     action :add
     zone   'home'
end

selinux_policy_port node['network']['port'] do
   protocol 'tcp'
   secontext 'ssh_port_t'
end

# Create custom systemd unit controlling our SFTP-dedicated sshd
systemd_unit 'sftp-ng-proxy.service' do
   content <<-EOU.gsub(/^\s+/, '')
   [Unit]
      Description=SFTP proxy service
      After=network.target
   [Service]
      Type=forking
      EnvironmentFile=/opt/bb/etc/sshd_env
      PIDFile=/var/run/sftp-ng-proxy.pid
      ExecStart=/usr/sbin/sshd $SSHD_OPTS 
      ExecReload=/bin/kill -HUP $MAINPID
      KillMode=process
      Restart=on-failure
   [Install]
      WantedBy=multi-user.target
      Alias=sftppxy.service
      EOU

   #user 'root'
   action [:create, :start, :enable]
end

