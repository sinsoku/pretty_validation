module PrettyValidation
  class Schema
    def self.table_names
      ActiveRecord::Base
        .connection.tables
        .delete_if { |t| t == ActiveRecord::SchemaMigration.table_name || t == 'ar_internal_metadata' }
    end

    def self.columns(table_name)
      ActiveRecord::Base.connection.columns(table_name)
    end

    def self.indexes(table_name)
      ActiveRecord::Base.connection.indexes(table_name)
    end
  end
end
