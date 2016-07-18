require 'active_record'
require 'active_support'
require 'pretty_validation/config'
require 'pretty_validation/railtie'
require 'pretty_validation/version'

module PrettyValidation
  autoload :NewHashSyntax, 'pretty_validation/new_hash_syntax'
  autoload :Renderer, 'pretty_validation/renderer'
  autoload :Schema, 'pretty_validation/schema'
  autoload :Validation, 'pretty_validation/validation'
  autoload :ValidationFindable, 'pretty_validation/validation_findable'
end

autoload :ValidationGenerator, 'generators/validation/validation_generator'
