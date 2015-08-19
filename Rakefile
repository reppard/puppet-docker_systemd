require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint::RakeTask.new :lint do |config|
  config.relative = true
  config.ignore_paths = ["spec/fixtures/**/*.pp", "pkg/**/*.pp", "vendor/**/*.pp"]
end
