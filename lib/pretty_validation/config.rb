module PrettyValidation
  def self.configure
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end

  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:auto_generate) { true }
    config_accessor(:auto_injection) { true }
    config_accessor(:ignored_columns) { [] }
  end
end
