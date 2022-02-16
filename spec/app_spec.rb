require 'rack/test'
require 'app'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'GET /', env: { AUTH_TOKEN: 'qwerty' } do
    let(:url) { 'http://example.com' }

    def dispatch
      basic_authorize auth_token, ''
      get '/', { url: url }
    end

    context 'with a valid auth_token' do
      let(:auth_token) { 'qwerty' }
      let(:content_type) { last_response.headers['Content-Type'] }
      let(:tmpfile) { Tempfile.new(['screenshot', '.png']) }

      it do
        expect(Screenshot).to receive(:fetch).with(url).and_return(tmpfile)
        dispatch
        expect(content_type).to eql('image/png')
        expect(last_response.status).to eql(200)
      end
    end

    context 'with an invalid auth_token' do
      let(:auth_token) { 'nope' }

      it do
        expect(Screenshot).to receive(:fetch).never
        dispatch
        expect(last_response.status).to eql(401)
      end
    end
  end
end
