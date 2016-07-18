class ValidationGenerator < Rails::Generators::NamedBase
  # Require to read a USAGE file
  source_root File.expand_path('../templates', __FILE__)
  class_option :verbose, type: :boolean, default: false, aliases: '-v',
                         group: :runtime, desc: 'Show validation code on screen'

  def create_validation
    r = PrettyValidation::Renderer.new(file_name.tableize)
    puts r.messages if options[:verbose]
    create_file r.file_path, r.render
  end
end
