require 'spec_helper'

describe 'docker_systemd::exec' do
  context 'with defaults for optional parameters' do
    let(:title) { 'httpd' }
    let(:params) {
      {
        :command => '/bin/touch /var/www/html/index.html'
      }
    }

    it {
      should contain_file(
               '/etc/systemd/system/docker-httpd-exec.service'
             ).that_notifies('Exec[systemctl-daemon-reload]')

      should contain_file('/etc/systemd/system/docker-httpd-exec.service').with(
               {
                 'ensure'  => 'present',
                 'content' => <<-EOF\
[Unit]
Description=Docker Exec for httpd
Requires=docker.service docker-httpd.service
After=docker.service docker-httpd.service

[Service]
Type=oneshot
Restart=on-failure
RestartSec=5
RemainAfterExit=yes
ExecStart=/usr/bin/docker exec -i httpd /bin/touch /var/www/html/index.html

[Install]
WantedBy=multi-user.target
EOF
               })
    }

    it {
      should contain_service('docker-httpd-exec.service').with(
               {
                 'ensure'   => 'running',
                 'enable'   => 'true',
                 'provider' => 'systemd'
               })
    }
  end

  context 'with all parameters configured' do

    let(:title) { 'httpd_touch' }
    let(:params) {
      {
        :command   => '/bin/touch /var/www/html/about.html',
        :container => 'httpd'
      }
    }

    it { should contain_file('/etc/systemd/system/docker-httpd_touch-exec.service').with(
                  {
                    'ensure'  => 'present',
                    'content' => <<-EOF\
[Unit]
Description=Docker Exec for httpd_touch
Requires=docker.service docker-httpd.service
After=docker.service docker-httpd.service

[Service]
Type=oneshot
Restart=on-failure
RestartSec=5
RemainAfterExit=yes
ExecStart=/usr/bin/docker exec -i httpd /bin/touch /var/www/html/about.html

[Install]
WantedBy=multi-user.target
EOF
                  })
    }

    it { should contain_service('docker-httpd_touch-exec.service').with(
                  {
                    'ensure'   => 'running',
                    'enable'   => 'true',
                    'provider' => 'systemd'
                  })
    }
  end
end
