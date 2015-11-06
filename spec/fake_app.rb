# config
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

module FakeApp
  class Application < Rails::Application
    config.secret_token = [*'A'..'z'].join
    config.session_store :cookie_store, key: '_myapp_session'
    config.active_support.deprecation = :log
    config.eager_load = false
    config.root = File.dirname(__FILE__)
  end
end
FakeApp::Application.initialize!

# migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    # schema_migrations
    create_table ActiveRecord::SchemaMigration.table_name do |t|
      t.string :version, null: false
    end

    create_table :users
  end
end
CreateAllTables.up
