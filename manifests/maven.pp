# Configure jenkins maven settings
class jenkins::maven (
  $settings_source = '', # e.g. puppet:///modules/bipposerver/sherlock/m2_settings.xml
) {

  file { "${jenkins::user_dir}/.m2":
    ensure  => directory,
    owner   => "tomcat${jenkins::tomcat_version}",
    group   => "tomcat${jenkins::tomcat_version}",
    require => [ Class['jenkins'], File['jenkins-user-dir'] ],
  }
  if $settings_source != '' {
    file { "${jenkins::user_dir}/.m2/settings.xml":
      ensure  => file,
      source  => $settings_source,
      owner   => "tomcat${jenkins::tomcat_version}",
      group   => "tomcat${jenkins::tomcat_version}",
      mode    => 0600,
      require => [ Class['jenkins'], File['/home/jenkins/.m2'] ],
    }
  }

}
