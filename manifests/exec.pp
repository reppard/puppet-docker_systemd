# Configure a oneshot service to exec a command from an existing container.

define docker_systemd::exec (
  $command,
  $container = $title,
) {

  $service_name = "docker-${title}-exec.service"
  $depends = "docker-${container}.service"

  file { "/etc/systemd/system/${service_name}":
    content => template('docker_systemd/etc/systemd/system/exec-container.service.erb'),
  }

  ~>
  service { $service_name:
    ensure   => running,
    enable   => true,
    provider => systemd,
  }

}
