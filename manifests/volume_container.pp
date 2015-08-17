define docker_systemd::volume_container (
  $image        = undef,
  $command      = undef,
  $depends      = undef,
  $volumes_from = undef,
  $links        = undef,
  $entrypoint   = undef,
) {

  $service_name = "docker-${title}.service"

  file { "/etc/systemd/system/${service_name}":
    content => template('docker_systemd/etc/systemd/system/data-container.service.erb'),
  }

  ~>
  service { $service_name:
    enable   => true,
    provider => systemd,
  }

}
