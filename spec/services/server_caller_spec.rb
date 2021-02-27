require 'rails_helper'

RSpec.describe ServerCaller, type: :service do
  let(:params) { {} }
  let(:url)    { 'posts' }
  let(:post)   { { 'id' => '1', 'title' => 'test title', 'body' => 'test body' } }
  subject { ServerCaller.call(verb, url, params) }

  describe 'GET' do
    let(:verb) { 'get' }
    context 'success' do
      it 'returns an array of posts' do
        allow(Net::HTTP).to receive(:get).and_return([post].to_json)
        expect(subject).to eq([post])
      end
    end
  end
end
