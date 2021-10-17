node 'appserver' {
exec{ 'apt-get update':
command => '/usr/bin/sudo apt-get update',
}

package{ 'curl':
ensure => installed,
require => Exec['apt-get update'],
}

exec{ 'SetRepo':
command => "/usr/bin/sudo echo \"$(hostname):$(/usr/bin/sudo ifconfig eth1 | grep 'inet ' | awk '{print \$2}')\" >> /home/vagrant/Shared/ipaddress ; /usr/bin/sudo apt install ca-certificates; /usr/bin/curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -",
}

package{'nodejs':
ensure => installed,
require => Exec['apt-get update'],
}
}

node 'dbserver' {
exec{ 'apt-get update':
command => "/usr/bin/sudo echo \"$(hostname):$(/usr/bin/sudo ifconfig eth1 | grep 'inet ' | awk '{print \$2}')\" >> /home/vagrant/Shared/ipaddress ; /usr/bin/sudo apt-get update",
}

package{'mysql-server':
ensure => installed,
require => Exec['apt-get update'],
}
}

node 'webserver' {
exec{ 'apt-get update':
command => "/usr/bin/sudo echo \"$(hostname):$(/usr/bin/sudo ifconfig eth1 | grep 'inet ' | awk '{print \$2}')\" >> /home/vagrant/Shared/ipaddress ; /usr/bin/sudo apt-get update",
}

package{'nginx':
ensure => installed,
require => Exec['apt-get update'],
}
}

node /^(tst*)/ {
exec{ 'apt-get update':
command => "/usr/bin/sudo echo \"$(hostname):$(/usr/bin/sudo ifconfig eth1 | grep 'inet ' | awk '{print \$2}')\" >> /home/vagrant/Shared/ipaddress ; /usr/bin/sudo apt-get update",
}
}