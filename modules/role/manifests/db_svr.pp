#- file:  modules/role/manifests/db.pp
#- Class: role::db_svr
#
# Class to define a db server role
#
class role::db_svr {

 include profile::base
 #include profile::secure
 include profile::monitoring
 include profile::db

}
