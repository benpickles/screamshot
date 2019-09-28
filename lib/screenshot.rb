require 'ferrum'

class Screenshot
  def self.fetch(url)
    new(url).fetch
  end

  def initialize(url)
    @url = url
  end

  def fetch
    Tempfile.new(['screenshot', '.png']).tap { |tmpfile|
      browser.goto(url)
      browser.screenshot(full: true, path: tmpfile.path)
      browser.quit
    }
  end

  private
    attr_reader :url

    def browser
      @browser ||= Ferrum::Browser.new
    end
end
