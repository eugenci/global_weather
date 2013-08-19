require "bundler/gem_tasks"
require 'rake/testtask'


Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = false
end


Rake::TestTask.new(:test_unit) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/unit/**/*_test.rb'
  test.verbose = false
end

task :default => :test
