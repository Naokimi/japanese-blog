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
        expect(Net::HTTP).to receive(:get).and_return([post].to_json)
        expect(subject).to eq([post])
      end
    end
  end

  describe 'POST' do
    let(:verb)   { 'post' }
    let(:params) { { 'post' => { 'title' => 'second title', 'body' => 'second body' } } }
    context 'success' do
      it 'creates a post' do
        req = double(Net::HTTP::Post)
        response = Net::HTTPSuccess.new(1.0, '200', 'OK')
        expect(Net::HTTP::Post).to receive(:new).and_return(req)
        expect(req).to receive(:body=)
        expect(Net::HTTP).to receive(:start).and_return(response)
        expect(response).to receive(:body).and_return(params.to_json)
        subject
      end
    end
  end
end
