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

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'config/**/*', 'lib/**/*', 'app/**/*', 'public/**/*', 'Rakefile']
  s.test_files   = Dir['test']
  
  s.require_paths = ["lib"]

  # Spree
  s.add_dependency('spree_core', '>= 0.60.0')
  s.add_dependency('rdiscount',  '>= 1.6.8')
  
  # Development
	s.add_development_dependency('shoulda',            '>= 2.11.3')
	s.add_development_dependency('dummier',            '>= 0.2.0')
	s.add_development_dependency('factory_girl',       '>= 2.0.0.beta4')
	s.add_development_dependency('capybara',           '>= 1.0.0')
	s.add_development_dependency('sqlite3',            '>= 1.3.3')
  s.add_development_dependency('spork',              '>= 0.9.0.rc9')
  s.add_development_dependency('spork-testunit',     '>= 0.0.5')
end
