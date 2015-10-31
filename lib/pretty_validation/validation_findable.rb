module PrettyValidation
  module ValidationFindable
    extend ActiveSupport::Concern

    class_methods do
      def inherited(kls)
        super(kls)
        begin
          kls.include "#{kls}Validation".constantize if kls.superclass == ::ActiveRecord::Base
        rescue NameError
          # nothing
        end
      end
    end
  end
end
