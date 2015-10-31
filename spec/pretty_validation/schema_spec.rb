require 'spec_helper'

module PrettyValidation
  describe Schema do
    describe '.table_names' do
      subject { Schema.table_names }
      it { is_expected.to contain_exactly 'users' }
    end
  end
end
