class profile::proxy { 
 
 class { 'nginx': }
 nginx::resource::vhost { 'dev-java-appserver.cfscos2.com':
  listen_port => 80,
  proxy       => 'http://localhost:8080',
 }
}