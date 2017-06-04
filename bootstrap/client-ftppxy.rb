# /etc/chef/client.rb
log_level        :auto
log_location     STDOUT
node_name	 "ftppxy"
chef_server_url  "https://192.168.122.10/organizations/skelton-onl"
ssl_verify_mode  :verify_none
validation_client_name "skelton-onl-validator"
