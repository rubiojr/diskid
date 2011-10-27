# encoding: utf-8

require 'rubygems'
require 'rake'
require './lib/diskid.rb'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.version = DiskID::VERSION
  gem.name = "diskid"
  gem.homepage = "http://github.com/rubiojr/diskid"
  gem.license = "MIT"
  gem.summary = %Q{Virtual Disk Identification Service}
  gem.description = %Q{Virtual Disk Identification Service}
  gem.email = "rubiojr@frameos.org"
  gem.authors = ["Sergio Rubio"]
  gem.add_runtime_dependency 'sinatra'
  gem.add_runtime_dependency 'clamp'
  gem.add_runtime_dependency 'alchemist'
  gem.add_runtime_dependency 'rest-client'
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :build

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "diskid #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
