# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "uniform_notifier/version"

Gem::Specification.new do |s|
  s.name        = "uniform_notifier"
  s.version     = UniformNotifier::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = "http://rubygems.org/gems/uniform_notifier"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "uniform_notifier"
  
  s.add_development_dependency "rspec"
  s.add_development_dependency "ruby-growl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
