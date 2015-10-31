tasks = Rake.application.instance_variable_get '@tasks'
original_db_dump = tasks.delete 'db:_dump'

namespace :validation do
  desc 'Generate validations from database schema'
  task :generate do
    PrettyValidation::Renderer.generate
  end
end

namespace :db do
  task :_dump do
    original_db_dump.invoke
    PrettyValidation::Renderer.generate
  end
end
