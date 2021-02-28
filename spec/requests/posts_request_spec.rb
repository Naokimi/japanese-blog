require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:server_caller) { double(ServerCaller) }
  let(:pozt)          { { 'id' => '1', 'title' => 'test', 'body' => 'test', 'created_at' => Time.now.to_s } }
  let(:posts)         { { 'posts' => [pozt] } }

  describe 'GET /index' do
    before do
      allow(ServerCaller).to receive(:call).and_return(posts)
    end

    it 'returns http success' do
      get '/posts'
      expect(ServerCaller).to have_received(:call)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    before do
      allow(ServerCaller).to receive(:call).and_return(pozt, { 'comments' => [] })
    end

    it 'returns http success' do
      get '/posts/1'
      expect(ServerCaller).to have_received(:call).exactly(2).time
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'success' do
      before do
        allow(ServerCaller).to receive(:call).and_return(pozt)
      end

      it 'redirects' do
        post '/posts', params: { 'post' => { 'title' => 'test', 'body' => 'test' } }
        expect(ServerCaller).to have_received(:call)
        expect(response).to have_http_status(302)
      end
    end

    context 'failure' do
      before do
        error = { 'errors' => ['press reset'] }
        allow(ServerCaller).to receive(:call).and_return(error)
      end

      it 'renders new' do
        post '/posts', params: { 'post' => { 'title' => 'no body' } }
        expect(ServerCaller).to have_received(:call)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/posts/new'
      expect(response).to have_http_status(:success)
    end
  end
end
