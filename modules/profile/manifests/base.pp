#- file:  modules/profile/manifests/base.pp
#- Class: profile::base
#
# Class to install the base requirements for any host
#
class profile::base {

    package { "ntp": 
        ensure => installed 
    }

    service { "ntp":
        ensure  => running,
        require => Package['ntp']
    }
	
	 class { 'sensu':
     rabbitmq_password  => 'correct-horse-battery-staple',
     rabbitmq_host      => 'sensu-server.foo.com',
     subscriptions      => 'sensu-test',
     safe_mode          => true,
   }

  sensu::check { "diskspace":
    command => '/etc/sensu/plugins/system/check-disk.rb',
  }
}
