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

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_paths = ["lib"]

  s.add_runtime_dependency('spree_core',  '~> 2.0')
  s.add_runtime_dependency('spree_frontend',  '~> 2.0')
  s.add_runtime_dependency('spree_backend',  '~> 2.0')
  s.add_runtime_dependency('rdiscount',   '~> 1.6.8')

  s.add_development_dependency 'm'
  s.add_development_dependency('mocha',        '0.13.3')
  s.add_development_dependency('shoulda',      '~> 3.0.0')
  s.add_development_dependency('shoulda-context', '1.0.0')
  s.add_development_dependency('dummier',      '~> 0.3.0')
  s.add_development_dependency('factory_girl', '~> 2.6.0')
  s.add_development_dependency('capybara',     '~> 2.1.0')
  s.add_development_dependency('selenium-webdriver', '2.35.0')
  s.add_development_dependency('sqlite3',      '~> 1.3.4')
  s.add_development_dependency('simplecov',    '~> 0.6.1')
  s.add_development_dependency('sass-rails',   '~> 3.2')
  s.add_development_dependency('jquery-rails', '~> 3.0.0')
  s.add_development_dependency('coffee-rails', '~> 3.2')
  # s.add_development_dependency('debugger')

end
