# Configure simple nginx proxy
class jenkins::nginx (
	$server_name,
) {

  nginx::site { $server_name:
    content  => template('jenkins/jenkins.nginx.erb'),
  }

}
