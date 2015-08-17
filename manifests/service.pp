define docker_systemd::service (
  $image        = undef,
  $command      = undef,
  $depends      = undef,
  $volumes_from = undef,
  $links        = undef,
  $entrypoint   = undef,
) {

  $service_name = "docker-${title}.service"

  file { "/etc/systemd/system/${service_name}":
    content => template('docker_systemd/etc/systemd/system/run-container.service.erb'),
  }

  ~>
  service { $service_name:
    ensure   => running,
    enable   => true,
    provider => systemd,
  }

}
