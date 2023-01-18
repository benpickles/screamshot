require 'screenshot'

RSpec.describe Screenshot do
  describe '.call' do
    subject { described_class.call(**args) }

    let(:browser) { instance_double(Ferrum::Browser, goto: nil, quit: nil, screenshot: nil) }
    let(:tempfile) { instance_double(Tempfile, path: 'path') }
    let(:url) { 'URL' }

    before do
      allow(Ferrum::Browser).to receive(:new).and_return(browser)
      allow(Tempfile).to receive(:new).and_return(tempfile)
    end

    context 'with a url' do
      let(:args) { { url: url } }

      it 'passes the url and the correct defaults' do
        expect(Ferrum::Browser).to receive(:new).with({
          browser_options: {},
          window_size: [1024, 768],
        }).and_return(browser)

        expect(browser).to receive(:goto).with(url)
        expect(browser).to receive(:screenshot).with({
          full: false,
          path: 'path',
          scale: 1,
        })

        expect(subject).to be(tempfile)
      end
    end

    context 'with full=true' do
      let(:args) { { full: true, url: url } }

      it do
        expect(browser).to receive(:screenshot).with(
          hash_including(full: true)
        )

        expect(subject).to be(tempfile)
      end
    end

    context 'with prefers_reduced_motion=true' do
      let(:args) { { prefers_reduced_motion: true, url: url } }

      it do
        expect(Ferrum::Browser).to receive(:new).with(
          hash_including(
            browser_options: {
              'force-prefers-reduced-motion' => true,
            },
          )
        ).and_return(browser)

        expect(subject).to be(tempfile)
      end
    end

    context 'with a viewport' do
      let(:args) { { url: url, viewport: [123, 456] } }

      it do
        expect(Ferrum::Browser).to receive(:new).with(
          hash_including(window_size: [123, 456])
        ).and_return(browser)

        expect(subject).to be(tempfile)
      end
    end

    context 'with a scale' do
      let(:args) { { scale: 3, url: url } }

      it do
        expect(browser).to receive(:screenshot).with(
          hash_including(scale: 3)
        )

        expect(subject).to be(tempfile)
      end
    end
  end
end
