require 'pretty_validation/config'
require 'pretty_validation/schema'
require 'pretty_validation/validation'

module PrettyValidation
  class Renderer
    attr_reader :table_name

    def self.validations_path
      File.join('app', 'validations')
    end

    def self.generate(dry_run: false)
      if generate?(dry_run) && !File.directory?(validations_path)
        FileUtils.mkdir_p validations_path
      end

      Schema.table_names.each do |t|
        r = new t
        next if r.validations.empty?

        r.write! if generate?(dry_run)
      end
    end

    def self.generate?(dry_run)
      !dry_run
    end

    def initialize(table_name)
      @table_name = table_name
    end

    def render
      @render ||= <<-EOF
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
      File.join(Renderer.validations_path, file_name)
    end

    def write!
      File.write(file_path, render)
    end

    def validations
      sexy_validations + uniq_validations
    end

    def messages
      [
        announce('generating'),
        render,
        announce('generated'),
        "\n"
      ].join
    end

    private

    def sexy_validations
      Validation.sexy_validations(table_name)
    end

    def uniq_validations
      Validation.unique_validations(table_name)
    end

    def announce(message)
      text = "#{module_name}: #{message}"
      length = [0, 75 - text.length].max
      "== #{text} #{'=' * length}\n"
    end
  end
end
