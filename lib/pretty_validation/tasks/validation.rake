tasks = Rake.application.instance_variable_get '@tasks'
original_db_dump = tasks.delete 'db:_dump'

namespace :validation do
  desc 'Generate validations from database schema'
  task generate: :environment do
    require 'pretty_validation/renderer'
    PrettyValidation::Renderer.generate
  end
end

namespace :db do
  task :_dump do
    original_db_dump.invoke
    # Allow this task to be called as many times as required. An example is the
    # migrate:redo task, which calls other two internally that depend on this one.
    original_db_dump.reenable

    require 'pretty_validation/renderer'
    PrettyValidation::Renderer.generate
  end
end
