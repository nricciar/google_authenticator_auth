require 'rake'

spec = Gem::Specification.new do |s|
  s.name = "google_authenticator_auth"
  s.version = "1.0.0"
  s.author = "David Ricciardi"
  s.email = "nricciar@gmail.com"
  s.homepage = "http://github.com/nricciar/google_authenticator_auth"
  s.platform = Gem::Platform::RUBY
  s.summary = "A simple class to work with Google Authenticator from ruby"
  s.files = FileList["{lib}/**/*"].to_a +
    ["Rakefile"]
  s.require_path = "lib"
  s.description = File.read("README")
  s.test_files = FileList["{test}/*.rb"].to_a
  s.has_rdoc = false
  s.extra_rdoc_files = ["README","MIT-LICENSE"]
  s.description = %q{google authenticator auth}
  s.add_dependency 'builder'
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'activesupport'
end
