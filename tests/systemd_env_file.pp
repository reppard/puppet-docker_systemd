# Test the use of a systemd environment file.

# First, create the file with IMAGE and FOO variables.
file { '/etc/sysconfig/docker-grafana.env':
  ensure  => present,
  content => "IMAGE=ajsmith/grafana\nFOO=bar"
}

# Now create a container service which uses those variables. The IMAGE variable
# is used to specify the container image and the FOO variable is passed through
# to the container environment.
->
docker_systemd::container { 'grafana':
  image            => '$IMAGE',
  env              => ['FOO=${FOO}'],
  systemd_env_file => '/etc/sysconfig/docker-grafana.env',
}

# Finally, verify that the container environment has the FOO variable.
# Run `systemctl status docker-grafana-echo-foo-exec` to check this.
docker_systemd::exec { 'grafana-echo-foo':
  command   => 'bash -c \'echo $FOO\'',
  container => 'grafana',
}
