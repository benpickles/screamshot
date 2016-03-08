require 'capybara/poltergeist'

class Screenshot
  def self.fetch(url)
    new(url).fetch
  end

  def initialize(url)
    @url = url
  end

  def fetch
    Tempfile.new(['screenshot', '.png']).tap { |tmpfile|
      session.visit(url)
      session.save_screenshot(tmpfile.path, full: true)
      session.driver.quit
    }
  end

  private
    attr_reader :url

    def session
      @session ||= Capybara::Session.new(:poltergeist)
    end
end
