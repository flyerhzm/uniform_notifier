# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "uniform_notifier/version"

Gem::Specification.new do |s|
  s.name        = "uniform_notifier"
  s.version     = UniformNotifier::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Richard Huang"]
  s.email       = ["flyerhzm@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/uniform_notifier"
  s.summary     = %q{uniform notifier for rails logger, customized logger, javascript alert, javascript console, growl and xmpp}
  s.description = %q{uniform notifier for rails logger, customized logger, javascript alert, javascript console, growl and xmpp}

  s.rubyforge_project = "uniform_notifier"

  s.add_development_dependency "rspec"
  s.add_development_dependency "ruby-growl"
  s.add_development_dependency "xmpp4r"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
