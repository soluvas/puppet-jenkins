# Install jenkins git plugin
class jenkins::git (
  $email,
  $source = 'http://updates.jenkins-ci.org/latest/git.hpi',
) {

  file { "${jenkins::user_dir}/.gitconfig":
    ensure  => file,
    content => template('jenkins/gitconfig.erb'),
    owner   => "tomcat${jenkins::tomcat_version}",
    group   => "tomcat${jenkins::tomcat_version}",
    mode    => 0644,
    require => File['jenkins-user-dir'],
  }
  exec { download-git-plugin:
    command   => "wget -O '${jenkins::home}/plugins/git.hpi' '${source}'",
    user      => "tomcat${jenkins::tomcat_version}",
    group     => "tomcat${jenkins::tomcat_version}",
    path      => ['/bin', '/usr/bin'],
    creates   => "${jenkins::home}/plugins/git.hpi",
    logoutput => true,
    require   => Package['tomcat'],
    notify    => Service['tomcat'],
  }

}
