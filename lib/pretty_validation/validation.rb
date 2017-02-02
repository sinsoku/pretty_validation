require 'pretty_validation/monkey/new_hash_syntax'

module PrettyValidation
  class Validation
    using NewHashSyntax

    attr_reader :method_name, :column_name, :options

    def self.sexy_validations(table_name)
      columns = Schema.columns(table_name)
      columns = columns.reject { |x| x.name.in? %w(id created_at updated_at) }

      columns.map do |column|
        options = {}
        options[:presence] = true unless column.null
        case column.type
        when :integer
          options[:numericality] = true
          options[:allow_nil] = true if column.null
        when :boolean
          options[:commented] = true unless options.empty?
        end
        Validation.new('validates', column.name.to_sym, options) if options.present?
      end.compact
    end

    def self.unique_validations(table_name)
      Schema.indexes(table_name).select(&:unique).reverse.map do |x|
        column_name = x.columns[0]
        scope = x.columns[1..-1].map(&:to_sym)
        options = if scope.size > 1
                    { scope: scope }
                  elsif scope.size == 1
                    { scope: scope[0] }
                  end

        columns = Schema.columns(table_name)
        if x.columns.any?{|colname| col = columns.detect{|c| c.name == colname}; col.null }
          options ||= {}
          options[:allow_nil] = true
        end
        Validation.new('validates_uniqueness_of', column_name.to_sym, options)
      end
    end

    def initialize(method_name, column_name, options = nil)
      @method_name = method_name
      @column_name = column_name
      @options = options
    end

    def ==(other)
      method_name == other.method_name &&
        column_name == other.column_name &&
        options == other.options
    end

    def to_s
      commented = options ? options.delete(:commented) : false
      r = "#{method_name} #{column_name.inspect}"
      r << ", #{options.to_s}" unless options.blank?
      r = "# #{r}" if commented
      return r
    end
  end
end
