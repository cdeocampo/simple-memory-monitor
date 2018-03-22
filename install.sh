#!/bin/bash
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
yes | yum -y install puppet
hostname bpx.server.local
echo "bpx.server.local" >> /etc/resolv.conf
echo "127.0.0.1     bpx.server.local" >> /etc/hosts
sed -i -e 's/localhost.localdomain/bpx.server.local/' /etc/sysconfig/network
service network restart