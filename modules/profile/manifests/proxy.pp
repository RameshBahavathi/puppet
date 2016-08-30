class profile::proxy { 
 
 class { 'nginx': }
  listen_port => 80,
  proxy       => 'http://localhost:8080',
 }
}