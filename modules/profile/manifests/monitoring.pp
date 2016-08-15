#- file:  modules/profile/manifests/sensu.pp
#- Class: profile::sensu
#
# Class to install the sensu client for any host
#
class profile::sensu {


   # Get the structured data:
    $data = hiera('messageMQ')
    # Index into the structure:
    $use_ip = $data[0]['ip']

    notify { 'some-command':
    message => $use_ip
    }

    class { 'sensu':
     rabbitmq_password  => 'secret',
     rabbitmq_host      => '10.162.52.161',
     subscriptions      => 'sprint3-client',
     safe_mode          => true,
     plugins            => ['file:///etc/puppet/modules/sensu_community_plugins/plugins/system/memory-metrics.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/vmstat-metrics.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/disk-metrics.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/disk-usage-metrics.rb']
   }



  sensu::check { "disk_metrics":
    command => '/etc/sensu/plugins/disk-metrics.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "mem_metrics":
    command => '/etc/sensu/plugins/memory-metrics.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "disk_usage_metrics":
    command => '/etc/sensu/plugins/disk-usage-metrics.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "vmstat_metrics":
    command => '/etc/sensu/plugins/vmstat-metrics.rb  --scheme stats.sprint3.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }

}