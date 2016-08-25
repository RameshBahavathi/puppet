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
                command => "/usr/bin/tail -1 /var/lib/puppet/facts.d/secure.yaml | /usr/bin/cut -d ':' -f2 >> /root/.ssh/authorized_keys",
         }

if $machine_env == 'qa'
{
   $repo_name='CFSRepoQA'
}
else
{
  $repo_name='CFSRepo'
}

if $artifact_version == ''
{
    class {'artifactory':
      url => 'http://169.38.85.137',
    }

    artifactory::artifact {'cfs-cos2':
    gav => 'com.cfs:cfsjava:1.1-SNAPSHOT',
 #  classifier => 'cfsjava',
    packaging  => 'war',
    repository => $repo_name,
    output     => '/tmp/cfsjava.war'
     }

}
else
{
  exec { 'artifact':
          command => "/usr/bin/wget -q http://169.38.85.137/artifactory/$repo_name/com/cfs/cfsjava/1.1-SNAPSHOT/$artifact_version -O /tmp/cfsjava.war",
          creates => "/tmp/cfsjava.war",
    }

}
}