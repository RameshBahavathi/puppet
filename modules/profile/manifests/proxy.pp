class profile::proxy { 
 
 class { 'nginx': }
  nginx::resource::vhost { $hostname:
  listen_port => 80,
  proxy       => 'http://localhost:8080',
 }
}