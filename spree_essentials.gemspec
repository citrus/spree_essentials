# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_essentials/version"
Gem::Specification.new do |s|
  s.name        = "spree_essentials"
  s.version     = SpreeEssentials::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "http://github.com/citrus/spree_essentials"
  s.summary     = %q{Spree Essentials add a cms and blog to your spree site.}
  s.description = %q{Spree Essentials .....}

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'config/**/*', 'lib/**/*', 'app/**/*', 'db/**/*', 'public/**/*', 'Rakefile']
  s.test_files   = Dir['test']
  
  s.require_paths = ["lib"]

  # Spree
  s.add_dependency('spree_core', '>= 0.30.1')
  s.add_dependency('spree_auth', '>= 0.30.1')
  
  # Blog
  s.add_dependency('meta_search',         '>= 1.0.1')
  s.add_dependency('acts-as-taggable-on', '>= 2.0.6')
  
  # Contents
  s.add_dependency('rdiscount', '>= 1.6.8')
  
  # Development
	s.add_development_dependency('shoulda', '>= 2.11.3')
	s.add_development_dependency('factory_girl', '>= 2.0.0.beta2')
	s.add_development_dependency('capybara', '>= 0.4.1')
	s.add_development_dependency('selenium-webdriver', '>= 0.1.3')
  s.add_development_dependency('sqlite3')
  s.add_development_dependency('faker')
  	
end