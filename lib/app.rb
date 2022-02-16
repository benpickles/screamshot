require_relative 'screenshot'
require 'sinatra/base'

class App < Sinatra::Base
  use Rack::Auth::Basic do |username, _|
    Rack::Utils.secure_compare(username, ENV.fetch('AUTH_TOKEN'))
  end

  get '/' do
    url = params[:url]
    tmpfile = Screenshot.fetch(url)
    send_file tmpfile.path
  end
end
