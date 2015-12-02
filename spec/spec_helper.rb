$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rails'

require 'simplecov'
SimpleCov.start
if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'active_record'
require 'active_support'
require 'pretty_validation'
# for generators
require 'generator_spec'
require 'generators/validation/validation_generator'

require 'fake_app'

# load support/*
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }
