# Configure a service to exec a command on an existing container.
#
# The reason to use this rather than a normal exec is to ensure this fires
# only after the container it needs has been created.
#
# Note that docker_systemd::exec will fire everytime systemd starts services.
#
define docker_systemd::exec (
  $command,
  $container = $title,
) {

  include ::docker_systemd

  $service_name = "docker-${title}-exec.service"
  $depends = "docker-${container}.service"

  file { "/etc/systemd/system/${service_name}":
    ensure  => present,
    content => template('docker_systemd/etc/systemd/system/exec-container.service.erb'),
    notify  => Exec['systemctl-daemon-reload'],
  }

  ~>
  service { $service_name:
    ensure   => running,
    enable   => true,
    provider => systemd,
  }

}
