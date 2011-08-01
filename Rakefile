#!/usr/bin/env rake
require 'rake/testtask'
require 'rdoc/task'
require 'single_test' 

SingleTest.load_tasks

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the to_csv plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end



desc 'Generate documentation for the to_csv plugin.'
RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ToCsv'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
