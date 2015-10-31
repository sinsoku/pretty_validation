shared_context 'add_column' do |column, type, options={}|
  klass = Class.new(ActiveRecord::Migration) do
    class_eval <<-EOF
      def self.up
        add_column :users, #{column.inspect}, #{type.inspect}, #{options.inspect}
      end
      def self.down
        remove_column :users, #{column.inspect}
      end
    EOF
  end

  before { klass.up }
  after { klass.down }
end

shared_context 'add_index' do |column, options={}|
  klass = Class.new(ActiveRecord::Migration) do
    class_eval <<-EOF
      def self.up
        add_index :users, #{column.inspect}, #{options.inspect}
      end
      def self.down
        remove_index :users, #{column.inspect}
      end
    EOF
  end

  before { klass.up }
  after { klass.down }
end
