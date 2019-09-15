require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :request do
  describe '#POST /api/v1/posts/{id}/reviews - create' do
    subject { post api_v1_reviews_path(post_id), params: { review: params, format: :json } }
    let(:params) { { mark: 5 } }
    let(:new_post) { create(:post) }
    let(:post_id) { new_post.id }

    context 'when data is valid' do
      it 'returns post average rating' do
        subject
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq('rating' => '5.0')
      end
    end

    context 'when post does not exist' do
      let(:post_id) { 'not_found' }
      let(:params) { { mark: 5 } }

      it 'returns not found' do
        subject
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)).to eq({
          'code' => 'not_found',
          'errors' => "Couldn't find Post with 'id'=not_found"})
      end
    end

    context 'when data is invalid' do
      let(:params) { { mark: 10 } }

      it 'returns error' do
        subject
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq(
          {'code' => 'validation_error',
           'errors' => ["Mark is not included in the list"]
          })
      end
    end
  end
end
