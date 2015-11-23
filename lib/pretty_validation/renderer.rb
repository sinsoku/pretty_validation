require 'pretty_validation/config'
require 'pretty_validation/schema'
require 'pretty_validation/validation'

module PrettyValidation
  class Renderer
    attr_reader :table_name

    def self.validations_path
      Rails.root.join('app', 'validations')
    end

    def self.generate
      return unless PrettyValidation.config.auto_generate

      FileUtils.mkdir_p validations_path unless File.directory? validations_path
      Schema.table_names.each do |t|
        r = new t
        r.write! unless r.validations.empty?
      end
    end

    def initialize(table_name)
      @table_name = table_name
    end

    def render
      <<-EOF
module #{module_name}
  extend ActiveSupport::Concern

  included do
    #{validations.join("\n    ")}
  end
end
      EOF
    end

    def module_name
      "#{table_name.classify}Validation"
    end

    def file_name
      "#{module_name.underscore}.rb"
    end

    def file_path
      Renderer.validations_path.join(file_name)
    end

    def write!
      File.write(file_path, render)
    end

    def validations
      sexy_validations + uniq_validations
    end

    private

    def sexy_validations
      Validation.sexy_validations(table_name)
    end

    def uniq_validations
      Validation.unique_validations(table_name)
    end
  end
end
