define docker_systemd::container (
  $ensure       = running,
  $enable       = true,
  $image        = undef,
  $command      = undef,
  $depends      = undef,
  $volumes_from = undef,
  $link         = undef,
  $publish      = undef,
  $entrypoint   = undef,
  $env_file     = undef,
) {

  if $image {
    $image_arg = $image
  } else {
    $image_arg = $title
  }

  $service_name = "docker-${title}.service"
  $docker_run_options = build_docker_run_options({
    link         => $link,
    name         => $title,
    publish      => $publish,
    volumes_from => $volumes_from,
    entrypoint   => $entrypoint,
    env_file     => $env_file,
    })

  file { "/etc/systemd/system/${service_name}":
    ensure  => present,
    content => template('docker_systemd/etc/systemd/system/run-container.service.erb'),
  }

  ~>
  service { $service_name:
    ensure   => $ensure,
    enable   => $enable,
    provider => systemd,
  }

}
