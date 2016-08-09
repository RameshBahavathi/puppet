#- file:  modules/tomcat/manifests/config.pp
#- Class: tomcat::config
#
# Class to configure tomcat
#
class tomcat::config {

  file { 'tomcat-html':
    ensure  => file,
    path    => '/var/lib/tomcat7/webapps/ROOT/index.html',
    require => Package['tomcat7'],
    content => template( "tomcat/index.html.erb" ),
    notify  => Service['tomcat7']
  }

  file { '/var/lib/tomcat7/webapps/sprint3.war':
    ensure => present,
    source  => "puppet:///modules/tomcat/sprint3.war",
    notify  => Service['tomcat7']
  }


 file { 'DBConnection':
    ensure  => file,
    path    => '/var/lib/tomcat7/webapps/sprint3/hello.jsp',
    require => Package['tomcat7'],
    content => template( "tomcat/hello.jsp.erb" ),
    notify  => Service['tomcat7']
  }
}
