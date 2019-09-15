require 'rails_helper'

RSpec.describe ReviewForm, type: :model do
  describe 'new/1' do
    subject { ReviewForm.new(params) }

    context 'when data is valid' do
      let(:params) { { mark: 1 } }

      it 'should be valid' do
        expect(subject.valid?).to be(true)
      end
    end

    context 'when data is invalid' do
      let(:params) { { mark: 101 } }

      it 'should be invalid' do
        expect(subject.valid?).to be(false)
        expect(subject.errors.messages).to eq(
          mark: ['is not included in the list'])
      end
    end

    context 'when data is empty' do
      let(:params) { {} }

      it 'should be invalid' do
        expect(subject.valid?).to be(false)
        expect(subject.errors.messages).to eq(
          mark: ["can't be blank", "is not included in the list"])
      end
    end
  end
end