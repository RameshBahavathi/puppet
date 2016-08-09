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
     subscriptions      => 'all',
     safe_mode          => true,
     plugins            => ['file:///etc/puppet/modules/sensu_community_plugins/plugins/system/vmstat-metrics.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/disk-metrics.rb']
   }



  sensu::check { "disk-metrics":
    command => '/etc/sensu/plugins/disk-metrics.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "vmstat-metrics":
    command => '/etc/sensu/plugins/vmstat-metrics.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }

}