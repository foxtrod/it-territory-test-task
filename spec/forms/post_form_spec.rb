require 'rails_helper'

RSpec.describe PostForm, type: :model do
  describe 'new/1' do
    subject { PostForm.new(params) }

    context 'when data is valid' do
      let(:params) do
        {
          title: 'New',
          body: 'Post',
          ip: '0.0.0.0',
          login: 'John'
        }
      end

      it 'should be valid' do
        expect(subject.valid?).to be(true)
      end
    end

    context 'when data is invalid' do
      let(:params) { { title: 'A' * 101 } }

      it 'should be invalid' do
        expect(subject.valid?).to be(false)
        expect(subject.errors.messages).to eq(
          body: ["can't be blank"],
          ip: ["can't be blank"],
          login: ["can't be blank"],
          title: ['is too long (maximum is 100 characters)'])
      end
    end
  end
end