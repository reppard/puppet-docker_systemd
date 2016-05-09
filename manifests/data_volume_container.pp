define docker_systemd::data_volume_container (
  $image  = undef,
  $volume = undef,
) {

  $service_name = "docker-${title}.service"
  $docker_run_options = build_docker_run_options({
    name       => $title,
    volume     => $volume,
    entrypoint => '/bin/true',
    })

  file { "/etc/systemd/system/${service_name}":
    ensure  => present,
    content => template('docker_systemd/etc/systemd/system/data-container.service.erb'),
  }

  ~>
  service { $service_name:
    enable   => true,
    provider => systemd,
  }

}
