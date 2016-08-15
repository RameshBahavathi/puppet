#- file:  modules/profile/manifests/secure.pp
#- Class: profile::secure
#
# Class to install the secure requirements for any host
#
class profile::secure {


  exec{'credentials':
          command => "/usr/bin/wget -q https://s3.ap-south-1.amazonaws.com/cg-cfs-immediate/pwd.yaml.gpg -O /etc/puppet/hiera/hieradata/dev/pwd.yaml.gpg && /usr/bin/gpg --passphrase $passphrase /etc/puppet/hiera/hieradata/$machine_env/pwd.yaml.gpg && tail -n 4 /etc/puppet/hiera/hieradata/$machine_env/pwd.yaml >> /etc/puppet/hiera/hieradata/$machine_env/$machine_role.yaml",
          creates => "/etc/puppet/hiera/hieradata/dev/pwd.yaml.gpg",
  }

  file{'/etc/puppet/hiera/pwd.yaml.gpg':
     mode => 0755,
   require => Exec["credentials"],
 }
 
}