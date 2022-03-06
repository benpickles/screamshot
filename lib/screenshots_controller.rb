require 'sinatra/base'
require_relative 'screenshot'

class ScreenshotsController < Sinatra::Base
  use Rack::Auth::Basic do |username, _|
    Rack::Utils.secure_compare(username, ENV.fetch('AUTH_TOKEN'))
  end

  get '/' do
    opts = {
      full: params[:full] == 'true' ? true : nil,
      prefers_reduced_motion: params['prefers-reduced-motion'] == 'reduce' ? 'reduce' : nil,
      scale: params.key?(:scale) ? params[:scale].to_i : nil,
      url: params[:url].to_s,
      viewport: params[:viewport]&.split(',', 2)&.map(&:to_i),
    }.compact

    tmpfile = Screenshot.call(**opts)

    send_file tmpfile.path
  end
end
