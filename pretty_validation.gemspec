# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pretty_validation/version'

Gem::Specification.new do |spec|
  spec.name          = "pretty_validation"
  spec.version       = PrettyValidation::VERSION
  spec.authors       = ["sinsoku"]
  spec.email         = ["sinsoku.listy@gmail.com"]

  spec.summary       = 'PrettyValidation generate validation modules from database schema'
  spec.description   = 'PrettyValidation generate validation modules from database schema'
  spec.homepage      = 'https://github.com/sinsoku/pretty_validation'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 4.0.0'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency 'rubocop'
end
