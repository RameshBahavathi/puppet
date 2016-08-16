#- file:  modules/profile/manifests/secure.pp
#- Class: profile::secure
#
# Class to install the secure requirements for any host
#
class profile::secure {


  exec{'credentials':
          command => "/usr/bin/wget -q https://s3.ap-south-1.amazonaws.com/cg-cfs-immediate/secure.yaml.gpg -O /etc/puppet/hiera/secure.yaml.gpg && /usr/bin/gpg --passphrase $passphrase /etc/puppet/hiera/secure.yaml.gpg && cp /etc/puppet/hiera/secure.yaml /var/lib/puppet/facts.d/secure.yaml",
          creates => "/etc/puppet/hiera/secure.yaml.gpg",
  }

  file{'/etc/puppet/hiera/secure.yaml.gpg':
     mode => 0755,
   require => Exec["credentials"],
  }
 
}