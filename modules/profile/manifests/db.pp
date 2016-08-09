#- file:  modules/profile/manifests/db.pp
#- Class: profile::db
#
# Class to incorporate all db components
#
class profile::db {
   class { '::mysql::server':
  root_password    => 'strongpassword',
  override_options => { 'mysqld' => { 'max_connections' => '1024' } }
       }
}




