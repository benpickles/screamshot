require 'rack-timeout'
require './lib/app'
require './lib/public'

use Rack::Timeout

run Rack::URLMap.new({
  '/' => Public,
  '/screenshot' => App,
})
