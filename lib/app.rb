require_relative 'public_controller'
require_relative 'screenshots_controller'

App = Rack::URLMap.new({
  '/' => PublicController,
  '/screenshot' => ScreenshotsController,
})
