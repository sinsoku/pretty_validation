require 'rails'

module PrettyValidation
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'pretty_validation/tasks/validation.rake'
    end

    ActiveSupport.on_load :active_record do
      ActiveRecord::Base.include PrettyValidation::ValidationFindable
    end
  end
end
