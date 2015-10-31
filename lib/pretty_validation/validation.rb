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
        options[:numericality] = true if column.type == :integer

        Validation.new('validates', column.name.to_sym, options) if options.present?
      end.compact
    end

    def self.unique_validations(table_name)
      Schema.indexes(table_name).select(&:unique).reverse.map do |x|
        column_name = x.columns[0]
        scope = x.columns[1..-1].map(&:to_sym)
        options = if scope.size > 1
                    {scope: scope}
                  elsif scope.size == 1
                    {scope: scope[0]}
                  end

        Validation.new('validates_uniqueness_of', column_name.to_sym, options)
      end
    end

    def initialize(method_name, column_name, options=nil)
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
      if options.blank?
        "#{method_name} #{column_name.inspect}"
      else
        "#{method_name} #{column_name.inspect}, #{options.to_s}"
      end
    end
  end
end
