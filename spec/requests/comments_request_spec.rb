require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'POST /create' do
    it 'returns http success' do
      post '/posts/1/comments', params: { 'comment' => { 'name' => 'test', 'body' => 'third body' } }
      expect(response).to have_http_status(302)
    end
  end
end
