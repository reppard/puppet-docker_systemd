require 'spec_helper'
describe 'docker_systemd' do

  context 'with defaults for all parameters' do
    it { should contain_class('docker_systemd') }
  end
end
