module PrettyValidation
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'pretty_validation/tasks/validation.rake'
    end

    initializer 'pretty_validation' do
      if PrettyValidation.config.auto_injection
        ActiveSupport.on_load :active_record do
          ActiveRecord::Base.include ValidationFindable
        end
      end
    end
  end
end
