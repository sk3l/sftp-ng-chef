#!/bin/sh

knife bootstrap ftppxy --ssh-user ftppxyadmin --ssh-password ftppxyadmin --sudo --use-sudo-password --node-name ftppxy --run-list 'recipe[sftp_proxy]'
