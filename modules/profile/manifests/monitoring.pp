#- file:  modules/profile/manifests/sensu.pp
#- Class: profile::monitoring
#
# Class to install the sensu client for any host
#
class profile::monitoring {
  
    class { 'sensu':
     rabbitmq_password  => $rabbitmq_password,
     rabbitmq_host      => $rabbitmq_serverip,
     subscriptions      => $cloud_subcribtions,
     safe_mode          => true,
     plugins            => ['file:///etc/puppet/modules/sensu_community_plugins/plugins/system/memory-metrics.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/vmstat-metrics.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/disk-metrics.rb','file:///etc/puppet/modules/sensu_community_plugins/plugins/system/disk-usage-metrics.rb']
   }



  sensu::check { "disk_metrics":
    command => '/etc/sensu/plugins/disk-metrics.rb  --scheme stats.ipaas.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "mem_metrics":
    command => '/etc/sensu/plugins/memory-metrics.rb  --scheme stats.ipaas.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "disk_usage_metrics":
    command => '/etc/sensu/plugins/disk-usage-metrics.rb  --scheme stats.ipaas.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }
  
  sensu::check { "vmstat_metrics":
    command => '/etc/sensu/plugins/vmstat-metrics.rb  --scheme stats.ipaas.:::name:::',
	handlers => ["graphite"],
	type => 'metric'
  }

}
