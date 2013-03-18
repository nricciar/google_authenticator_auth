require 'rake'

require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :test

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.pattern = 'test/*_test.rb'
  test.verbose = true
end

if RUBY_VERSION =~ /^1\.9/
  require 'simplecov'
  desc "Code coverage detail"
  task :simplecov do
    ENV['COVERAGE'] = "true"
    Rake::Task['spec'].execute
  end
else
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
end

task :default => :test

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "google_authenticator_auth 1.0.1"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('MIT-LICENSE')
  rdoc.rdoc_files.include('lib/*.rb')
end
