require 'rack/test'
require 'screenshots_controller'

RSpec.describe ScreenshotsController do
  include Rack::Test::Methods

  def app
    described_class
  end

  describe 'GET /', env: { AUTH_TOKEN: 'qwerty' } do
    let(:params) { {} }

    def dispatch
      basic_authorize auth_token, ''
      get '/', params
    end

    context 'with a valid AUTH_TOKEN' do
      let(:auth_token) { 'qwerty' }
      let(:tmpfile) { Tempfile.new(['screenshot', '.png']) }
      let(:url) { 'http://example.com' }

      context 'with a URL param' do
        let(:params) { { url: url } }

        it do
          expect(Screenshot).to receive(:call)
            .with(url: url)
            .and_return(tmpfile)

          dispatch

          expect(last_response.status).to eql(200)
          expect(last_response.content_type).to eql('image/png')
        end
      end

      context 'with a valid viewport param' do
        let(:params) { { url: url, viewport: '800,600' } }

        it do
          expect(Screenshot).to receive(:call)
            .with(url: url, viewport: [800, 600])
            .and_return(tmpfile)

          dispatch

          expect(last_response.status).to eql(200)
          expect(last_response.content_type).to eql('image/png')
        end
      end

      context 'with the full param' do
        let(:params) { { full: 'true', url: url } }

        it do
          expect(Screenshot).to receive(:call)
            .with(full: true, url: url)
            .and_return(tmpfile)

          dispatch

          expect(last_response.status).to eql(200)
          expect(last_response.content_type).to eql('image/png')
        end
      end

      context 'with the scale param' do
        let(:params) { { scale: '3', url: url } }

        it do
          expect(Screenshot).to receive(:call)
            .with(scale: 3, url: url)
            .and_return(tmpfile)

          dispatch

          expect(last_response.status).to eql(200)
          expect(last_response.content_type).to eql('image/png')
        end
      end

      context 'with the prefers-reduced-motion param' do
        let(:params) { { 'prefers-reduced-motion' => 'reduce', url: url } }

        it do
          expect(Screenshot).to receive(:call)
            .with(prefers_reduced_motion: 'reduce', url: url)
            .and_return(tmpfile)

          dispatch

          expect(last_response.status).to eql(200)
          expect(last_response.content_type).to eql('image/png')
        end
      end
    end

    context 'with an invalid auth_token' do
      let(:auth_token) { 'nope' }

      it do
        expect(Screenshot).to receive(:call).never

        dispatch

        expect(last_response.status).to eql(401)
      end
    end
  end
end
