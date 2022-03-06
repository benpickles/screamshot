require 'mini_magick'
require 'integration_helper'

RSpec.describe(
  'integration tests',
  type: :feature,
  env: { AUTH_TOKEN: 'qwerty' }
) do
  it 'fetches a screenshot with the default options' do
    uri = screenshot_uri(url: test_uri)
    tempfile = download(uri)
    image = MiniMagick::Image.open(tempfile.path)

    expect(image.width).to eq(1024)
    expect(image.height).to eq(768)

    pixels = image.get_pixels
    topleft = pixels[0][0]
    bottomright = pixels[-1][-1]

    expect(topleft).to eq([255, 0, 0])
    expect(bottomright).to eq([0, 0, 255])
  ensure
    tempfile&.unlink
  end

  it 'controls the viewport size' do
    uri = screenshot_uri(
      url: test_uri,
      viewport: '800,600',
    )
    tempfile = download(uri)
    image = MiniMagick::Image.open(tempfile.path)

    expect(image.width).to eq(800)
    expect(image.height).to eq(600)

    pixels = image.get_pixels
    topleft = pixels[0][0]
    bottomright = pixels[-1][-1]

    expect(topleft).to eq([255, 0, 0])
    expect(bottomright).to eq([255, 255, 0])
  ensure
    tempfile&.unlink
  end

  it 'controls the scale' do
    uri = screenshot_uri(
      scale: 2,
      url: test_uri,
    )
    tempfile = download(uri)
    image = MiniMagick::Image.open(tempfile.path)

    expect(image.width).to eq(2048)
    expect(image.height).to eq(1536)

    pixels = image.get_pixels
    topleft = pixels[0][0]
    bottomright = pixels[-1][-1]

    expect(topleft).to eq([255, 0, 0])
    expect(bottomright).to eq([0, 0, 255])
  ensure
    tempfile&.unlink
  end

  it 'can fetch the full height' do
    uri = screenshot_uri(
      full: true,
      url: test_uri,
    )
    tempfile = download(uri)
    image = MiniMagick::Image.open(tempfile.path)

    expect(image.width).to eq(1024)
    expect(image.height).to eq(1800)

    pixels = image.get_pixels
    topleft = pixels[0][0]
    bottomright = pixels[-1][-1]

    expect(topleft).to eq([255, 0, 0])
    expect(bottomright).to eq([0, 255, 255])
  ensure
    tempfile&.unlink
  end

  it 'triggers prefers-reduced-motion mode' do
    uri = screenshot_uri(
      'prefers-reduced-motion' => 'reduce',
      url: test_uri,
    )
    tempfile = download(uri)
    image = MiniMagick::Image.open(tempfile.path)

    pixels = image.get_pixels
    topleft = pixels[0][0]

    expect(topleft).to eq([255, 0, 255])
  ensure
    tempfile&.unlink
  end
end
