# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tiktalik/version"

Gem::Specification.new do |s|
  s.name        = "tiktalik"
  s.version     = Tiktalik::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bernard Potocki"]
  s.email       = ["bernard.potocki@imanel.org"]
  s.homepage    = "http://github.com/tiktalik-cloud/tiktalik-ruby"
  s.summary     = %q{Tiktalik.com Ruby API library}
  s.description = %q{Tiktalik.com Ruby API library}

  s.add_dependency 'faraday', '~> 0.8.8'
  s.add_dependency 'multi_json', '~> 1.7.9'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
