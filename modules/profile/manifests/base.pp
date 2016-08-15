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

}