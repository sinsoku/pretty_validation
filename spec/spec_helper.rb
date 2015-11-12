$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rails'
require 'active_record'
require 'active_support'
require 'pretty_validation'
require 'pretty_validation/renderer'
require 'fake_app'

# load support/*
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }
