require 'rack/test'
require 'app'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'POST /screenshot' do
    let(:url) { 'http://example.com' }

    it do
      expect(Screenshot).to receive(:fetch).with(url)
      post '/screenshot', { url: url }
    end
  end
end
