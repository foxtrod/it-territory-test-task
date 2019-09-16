require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :request do
  describe '#POST /api/v1/posts - create' do
    subject { post api_v1_posts_path, params: { post: params, format: :json } }

    context 'when data is valid' do
      let(:params) { attributes_for(:post, login: 'Vlad') }

      it { expect { subject }.to change { User.count }.by(1) }
      it { expect { subject }.to change { Post.count }.by(1) }
      it { expect { subject }.to change { LoginIp.count }.by(1) }

      it 'returns post' do
        subject
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(
          'title' => params[:title],
          'body' => params[:body],
          'ip' => params[:ip],
          'login' => params[:login],
          'rating' => '0.0'
        )
      end

      context 'when user exists' do
        let!(:user) { create(:user, login: 'Vlad') }

        it 'does not create user' do
          expect { subject }.to change { User.count }.by 0
        end
      end
    end

    context 'when data is invalid' do
      let(:params) { { post: {title: nil} } }

      it 'returns error' do
        subject
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq(
        {'code' => 'validation_error',
         'errors' => ["Title can't be blank",
                      "Body can't be blank",
                      "Login can't be blank",
                      "Ip can't be blank"]
        })
      end
    end
  end

  describe '#GET /api/v1/posts/top - top' do
    subject { get top_api_v1_posts_path, params: { amount: 3, format: :json } }

    before do
      10.times { create(:post) }
    end

    it 'returns top 3 posts' do
      subject
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).count).to eq(3)
    end
  end

  describe 'GET #ip_list' do
    subject { get ip_list_api_v1_posts_path, params: { format: :json } }

    let!(:login1) { create(:login_ip, ip: '0.0.0.0', login: '1') }
    let!(:login3) { create(:login_ip, ip: '0.0.0.0', login: '2') }
    let!(:login4) { create(:login_ip, ip: '0.0.0.1', login: '3') }

    it 'returns ips with list of logins' do
      subject
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).first).to eq ({
        'ip' => '0.0.0.0',
        'logins' => ['1', '2']
      })
    end
  end
end
