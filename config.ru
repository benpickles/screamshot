require 'rack-timeout'
require_relative 'lib/app'

use Rack::Timeout

run App
