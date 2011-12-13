# encoding: UTF-8
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
end

desc "Sets display port and runs tests on travis-ci"
task :travis do
  puts "Starting to run rake test..."
  system("export DISPLAY=:99.0 && bundle exec rake test")
  raise "rake test failed!" unless $?.exitstatus == 0
end

task :default => :test
