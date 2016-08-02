# == Class: docker_systemd
#
# Configure Docker container services in systemd.

class docker_systemd {

  exec { 'systemctl-daemon-reload':
    command     => '/usr/bin/systemctl daemon-reload',
    refreshonly => true,
  }

}
