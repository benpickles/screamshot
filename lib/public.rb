require 'sinatra/base'

class Public < Sinatra::Base
  MAX_AGE = 3600

  set :root, File.expand_path('../../', __FILE__)
  set :static_cache_control, [:public, max_age: MAX_AGE]

  get '/' do
    cache_control :public, max_age: MAX_AGE
    send_file File.join(settings.public_folder, 'index.html')
  end
end
