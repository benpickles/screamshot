require 'net/http'
require 'uri'
require 'capybara/rspec'
require 'app'

# Trick Capybara into managing Puma for us.
class NeedsServerDriver < Capybara::Driver::Base
  def needs_server?() = true
end

Capybara.register_driver :needs_server do
  NeedsServerDriver.new
end

Capybara.app = App
Capybara.default_driver = :needs_server
Capybara.server = :puma, { Silent: true }

module UrlHelpers
  def base_uri(path: nil, query: nil, userinfo: nil)
    URI::HTTP.build(
      host: Capybara.current_session.server.host,
      port: Capybara.current_session.server.port,
      path:,
      query:,
      userinfo:,
    )
  end

  def download(uri)
    tempfile = Tempfile.new
    tempfile.binmode

    Net::HTTP.start(uri.hostname, uri.port) { |http|
      request = Net::HTTP::Get.new(uri)
      request.basic_auth(uri.user, uri.password) if uri.user

      http.request(request) do |response|
        response.read_body do |chunk|
          tempfile << chunk
        end
      end
    }

    tempfile.close
    tempfile
  end

  def screenshot_uri(params = {})
    query = params.map { |name, value|
      [
        CGI.escape(name.to_s),
        CGI.escape(value.to_s)
      ].join('=')
    }.join('&')

    base_uri(
      path: '/screenshot',
      query:,
      userinfo: ENV.fetch('AUTH_TOKEN'),
    )
  end

  def test_uri
    base_uri(path: '/test.html')
  end
end

RSpec.configure do |config|
  config.include UrlHelpers, type: :feature
end
