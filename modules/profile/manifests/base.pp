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
     rabbitmq_password  => 'secret',
     rabbitmq_host      => '10.162.52.161',
     subscriptions      => 'sensu-test',
     safe_mode          => true,
     plugins            => ['file:///etc/puppet/modules/sensu_community_plugins/plugins/system/check-disk.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/check-cpu.rb']
   }



  sensu::check { "diskspace":
    command => '/etc/sensu/plugins/check-disk.rb',
  }
  
  sensu::check { "cpuusage":
    command => '/etc/sensu/plugins/check-cpu.rb',
  }

}