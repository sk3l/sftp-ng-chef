#!/bin/bash

pushd ../cookbooks/sftp_proxy
berks install
berks upload
knife cookbook upload sftp_proxy --force
popd
