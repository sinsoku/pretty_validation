module PrettyValidation
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'pretty_validation/tasks/validation.rake'
    end

    config.to_prepare do
      if PrettyValidation.config.auto_injection
        ActiveSupport.on_load :active_record do
          require 'pretty_validation/validation_findable'
          ActiveRecord::Base.include PrettyValidation::ValidationFindable
        end
      end
    end
  end
end
