class profile::proxy { 
 
 class { 'nginx': }
  nginx::resource::vhost { $fqdn:
  listen_port => 80,
  proxy       => 'http://localhost:8080',
 }
}
