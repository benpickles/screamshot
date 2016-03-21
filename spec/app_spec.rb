require 'rack/test'
require 'app'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'GET /' do
    let(:url) { 'http://example.com' }

    def dispatch
      basic_authorize api_token, ''
      get '/', { url: url }
    end

    context 'with a valid api_token' do
      let(:api_token) { ENV.fetch('API_TOKEN') }
      let(:content_type) { last_response.headers['Content-Type'] }
      let(:tmpfile) { Tempfile.new(['screenshot', '.png']) }

      it do
        expect(Screenshot).to receive(:fetch).with(url).and_return(tmpfile)
        dispatch
        expect(content_type).to eql('image/png')
        expect(last_response.status).to eql(200)
      end
    end

    context 'with an invalid api_token' do
      let(:api_token) { 'nope' }

      it do
        expect(Screenshot).to receive(:fetch).never
        dispatch
        expect(last_response.status).to eql(401)
      end
    end
  end
end
