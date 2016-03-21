require './lib/app'
require './lib/public'

run Rack::URLMap.new({
  '/' => Public,
  '/screenshot' => App,
})
