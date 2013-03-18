require 'rake'
require 'rake/testtask'
require 'rdoc/task'

require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :test

desc 'Generate documentation for the google_authenticator_auth plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'google_authenticator_auth'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

find_file = lambda do |name|
  file_name = lambda {|path| File.join(path, "#{name}.rb")}
  root = $:.detect do |path|
    File.exist?(file_name[path])
  end
  file_name[root] if root
end

TEST_LOADER = find_file['rake/rake_test_loader']
multiruby = lambda do |glob|
  system 'multiruby', TEST_LOADER, *Dir.glob(glob)
end

Rake::TestTask.new(:test) do |test|
  test.ruby_opts << "-W"
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end
