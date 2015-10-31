def build(method_name, column_name, options=nil)
  PrettyValidation::Validation.new(method_name, column_name, options)
end
