require 'ferrum'
require 'tempfile'

class Screenshot
  DEFAULT_VIEWPORT = [1024, 768].freeze

  def self.call(...)
    new(...).call
  end

  attr_reader :full, :prefers_reduced_motion, :scale, :url, :viewport

  def initialize(
    full: false,
    prefers_reduced_motion: nil,
    scale: 1,
    url:,
    viewport: DEFAULT_VIEWPORT
  )
    @full = full
    @prefers_reduced_motion = prefers_reduced_motion
    @scale = scale
    @url = url
    @viewport = viewport
  end

  def call
    Tempfile.new(['screenshot', '.png']).tap { |tmpfile|
      browser.goto(url)
      browser.screenshot(
        full:,
        path: tmpfile.path,
        scale:,
      )
      browser.quit
    }
  end

  private
    def browser
      @browser ||= Ferrum::Browser.new(
        browser_options: {
          'force-prefers-reduced-motion': prefers_reduced_motion,
        }.compact,
        window_size: viewport,
      )
    end
end
