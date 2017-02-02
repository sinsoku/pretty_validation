module PrettyValidation
  def self.configure
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end

  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:auto_generate) { false }
    config_accessor(:auto_injection) { true }
  end
end
