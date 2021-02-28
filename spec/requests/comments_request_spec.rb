require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:comment) { { 'id' => '1', 'name' => 'test', 'body' => 'test', 'created_at' => Time.now.to_s } }

  describe 'POST /create' do
    before do
      allow(ServerCaller).to receive(:call).and_return(comment)
    end

    it 'returns http redirect' do
      post '/posts/1/comments', params: { 'comment' => { 'name' => 'test', 'body' => 'third body' } }
      expect(ServerCaller).to have_received(:call)
      expect(response).to have_http_status(302)
    end
  end
end
