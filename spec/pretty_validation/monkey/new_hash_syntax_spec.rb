require 'spec_helper'

module NewHashSyntax
  using NewHashSyntax

  describe '#to_s' do
    describe '{a: 1}.to_s' do
      subject { {a: 1}.to_s }
      it { is_expected.to eq 'a: 1' }
    end
    describe '{a: [1, 2]}.to_s' do
      subject { {a: [1, 2]}.to_s }
      it { is_expected.to eq 'a: [1, 2]' }
    end
  end
end
