# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "opsworks_deployer"
  gem.homepage = "https://github.com/miagao/opsworks_deployer"
  gem.license = "MIT"
  gem.summary = "Task to deploy via CLI on Amazon OpsWorks."
  gem.description = "Task to deploy via CLI on Amazon OpsWorks."
  gem.email = "miagao@gmail.com"
  gem.authors = [ "Luciano Issoe", "Flavio Mori" ]
  gem.files.include 'lib/config/aws.yml.erb'
  gem.files.include 'lib/config/opsworks.yml.erb'
end
Jeweler::RubygemsDotOrgTasks.new
