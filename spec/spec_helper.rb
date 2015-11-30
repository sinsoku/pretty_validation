$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rails'

begin
  require 'yaml'
  yaml = YAML.load_file('.travis.yml')
  if ENV['TRAVIS_RUBY_VERSION'] == yaml['rvm'][-1].to_s
    require 'codeclimate-test-reporter'
    CodeClimate::TestReporter.start
  end
rescue LoadError
  # nothing
end

require 'active_record'
require 'active_support'
require 'pretty_validation'
# for generators
require 'rails/generators/test_case'
require 'generators/validation/validation_generator'

require 'fake_app'

# load support/*
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }
