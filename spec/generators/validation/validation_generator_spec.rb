require 'spec_helper'

describe ValidationGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  it 'creates a test initializer' do
    run_generator %w(user)

    assert_file 'app/validations/user_validation.rb', /module UserValidation/
  end
end
