name              'sftp_proxy'
maintainer        'Mike Skelton'
maintainer_email  'mskelton8@bloomberg.net'
license           'all_rights'
description       'Installs/Configures sftp_proxy'
long_description  'Installs/Configures sftp_proxy'
version           '0.1.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/sftp_proxy/issues' if respond_to?(:issues_url)

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/sftp_proxy' if respond_to?(:source_url)

depends  'openssh',        '~> 2.4.1'
depends  'firewalld',      '~> 1.1.5'
depends  'selinux_policy', '~> 2.0.1'
