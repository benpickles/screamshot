require 'rack/test'
require 'app'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'POST /screenshot' do
    let(:content_type) { response.headers['Content-Type'] }
    let(:url) { 'http://example.com' }

    before do
      tmpfile = Tempfile.new(['screenshot', '.png'])
      allow(Screenshot).to receive(:fetch).with(url).and_return(tmpfile)
    end

    it do
      get '/screenshot', { url: url }
      expect(content_type).to eql('image/png')
    end
  end
end
