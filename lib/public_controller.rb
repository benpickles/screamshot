require 'sinatra/base'

class PublicController < Sinatra::Base
  MAX_AGE = 3600

  set :public_folder, -> { File.join(root, 'docs') }
  set :root, File.expand_path('../', __dir__)
  set :static_cache_control, [:public, max_age: MAX_AGE]

  get '/' do
    cache_control :public, max_age: MAX_AGE
    send_file File.join(settings.public_folder, 'index.html')
  end
end
