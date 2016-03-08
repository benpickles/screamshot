require 'screenshot'

RSpec.describe Screenshot do
  describe '#fetch' do
    let(:driver) { double }
    let(:screenshot) { Screenshot.new(url) }
    let(:session) { double }
    let(:url) { 'URL' }

    subject { screenshot.fetch }

    before do
      expect(session).to receive(:driver).and_return(driver)
      expect(session).to receive(:save_screenshot)
      expect(session).to receive(:visit).with(url)

      expect(driver).to receive(:quit)

      expect(Capybara::Session).to receive(:new).and_return(session)
    end

    it { should be_a(Tempfile) }
  end
end
