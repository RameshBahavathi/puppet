#- file:  modules/role/manifests/web.pp
#- Class: role::web_svr
#
# Class to define a web server role
#
class role::web_svr {

 include profile::base
 include profile::secure
 include profile::sensu
 include profile::web

}
