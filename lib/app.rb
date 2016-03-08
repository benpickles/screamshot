require 'screenshot'
require 'sinatra/base'

class App < Sinatra::Base
  post '/screenshot' do
    url = params[:url]
    tmpfile = Screenshot.fetch(url)
    send_file tmpfile.path
  end
end
