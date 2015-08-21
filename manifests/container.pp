define docker_systemd::container (
  $image        = undef,
  $command      = undef,
  $depends      = undef,
  $volumes_from = undef,
  $link         = undef,
  $publish      = undef,
  $entrypoint   = undef,
) {

  $service_name = "docker-${title}.service"
  $docker_run_options = build_docker_run_options({
    link => $link,
    name => $title,
    publish => $publish,
    volumes_from => $volumes_from,
    })

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
