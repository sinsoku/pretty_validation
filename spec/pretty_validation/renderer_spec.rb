require 'spec_helper'

module PrettyValidation
  describe Renderer do
    describe '#render' do
      include_context 'add_column', :name, :string, null: false, default: ''
      include_context 'add_column', :age, :integer
      include_context 'add_column', :login_count, :integer, null: false, default: 0
      include_context 'add_column', :admin, :boolean
      include_context 'add_column', :writable, :boolean, null: false, default: true
      include_context 'add_index', :name, unique: true
      include_context 'add_index', [:name, :age], unique: true
      include_context 'add_index', [:name, :age, :admin], unique: true
      subject { Renderer.new('users').render }
      it do
        expected = <<-EOF
module UserValidation
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validates :age, numericality: true, allow_nil: true
    validates :login_count, presence: true, numericality: true
    validates :admin, inclusion: [true, false], allow_nil: true
    validates :writable, inclusion: [true, false]
    validates_uniqueness_of :name
    validates_uniqueness_of :name, scope: :age
    validates_uniqueness_of :name, scope: [:age, :admin]
  end
end
        EOF
        is_expected.to eq expected
      end
    end
  end
end
