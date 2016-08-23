#- file:  modules/profile/manifests/app.pp
#- Class: profile::app
#
# Class to incorporate all app components
#
class profile::app {


  class { 'java': } ->
   tomcat::install { '/opt/tomcat':
   source_url => 'https://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.70/bin/apache-tomcat-7.0.70.tar.gz',
}
  tomcat::instance { 'default':
  catalina_home => '/opt/tomcat',
} 

 tomcat::war { 'cfsjava.war':
  catalina_base => '/opt/tomcat',
  war_source    => '/tmp/cfsjava.war',
 }

}
