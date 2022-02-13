require 'screenshot'

RSpec.describe Screenshot do
  describe '#fetch' do
    let(:browser) { instance_double(Ferrum::Browser) }
    let(:screenshot) { Screenshot.new(url) }
    let(:url) { 'URL' }

    subject { screenshot.fetch }

    before do
      allow(browser).to receive(:goto).with(url)
      allow(browser).to receive(:screenshot)
      allow(browser).to receive(:quit)

      allow(Ferrum::Browser).to receive(:new).and_return(browser)
    end

    it { should be_a(Tempfile) }
  end
end
