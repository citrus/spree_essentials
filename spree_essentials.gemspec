# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_essentials/version"
Gem::Specification.new do |s|
  s.name        = "spree_essentials"
  s.version     = SpreeEssentials::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/spree_essentials"
  s.summary     = %q{Spree Essentials provides a base for several other Spree Commerce extensions. See readme for details...}
  s.description = %q{Spree Essentials provides a base for several other Spree Commerce extensions. The idea is to provide other extensions with common functionality such as an asset-upload interface, a markdown editor, and a common admin-navigation tab.}

  s.files        = Dir['CHANGELOG.md', 'README.md', 'LICENSE', 'config/**/*', 'lib/**/*', 'app/**/*', 'db/**/*', 'public/**/*', 'Rakefile']
  s.test_files   = Dir['test']
  
  s.require_paths = ["lib"]

  # Spree
  s.add_dependency('spree_core', '>= 0.30.0')
  s.add_dependency('spree_auth', '>= 0.30.0')
  s.add_dependency('rdiscount',  '>= 1.6.8')
  
  # Development
	s.add_development_dependency('shoulda',            '>= 2.11.3')
	s.add_development_dependency('dummier',            '>= 0.1.1')
	s.add_development_dependency('factory_girl',       '>= 2.0.0.beta2')
	s.add_development_dependency('cucumber',           '>= 0.10.2')
	s.add_development_dependency('capybara',           '>= 0.4.1')
	s.add_development_dependency('selenium-webdriver', '>= 0.1.3')
  s.add_development_dependency('sqlite3',            '>= 1.3.3')
  s.add_development_dependency('faker',              '>= 0.9.5')
  s.add_development_dependency('spork',              '>= 0.9.0.rc8')
  s.add_development_dependency('spork-testunit',     '>= 0.0.5')
  
end