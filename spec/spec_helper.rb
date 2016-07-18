$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rails'

require 'simplecov'
SimpleCov.start
if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'pretty_validation'
require 'fake_app'
require 'generator_spec'

# load support/*
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }
