# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_essential_example/version"

Gem::Specification.new do |s|

  s.name        = "spree_essential_example"
  s.version     = SpreeEssentialExample::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/spree_essentials"
  s.summary     = %q{Just an example for spree_essentials. This is not intended to be released.}
  s.description = %q{Just an example for spree_essentials. This is not intended to be released.}

  s.files         = []
  s.test_files    = []
  
  s.require_paths = ["lib"]

  s.add_runtime_dependency("spree_essentials", "~> #{SpreeEssentials::VERSION}")
	
end
