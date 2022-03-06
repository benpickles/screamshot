# Screamshot

[![CI](https://github.com/benpickles/screamshot/actions/workflows/tests.yml/badge.svg)](https://github.com/benpickles/screamshot/actions/workflows/tests.yml)

![Screamshot logo](docs/logo.png)

A synchronous HTTP screenshot service built on Sinatra and headless Chrome (via Ferrum).

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/benpickles/screamshot)

## Usage

Trigger a screenshot by making a `GET` request to `/screenshot` with a `url` querystring parameter. The endpoint is protected by basic HTTP authentication with your `AUTH_TOKEN`.

```sh
$ curl "http://AUTH_TOKEN@screamshot.dev/screenshot?url=http://example.com" > screenshot.png
```

## Options

Pass options via querystring parameters. A more complicated Screamshot URL might be the following combination of available options:

```
http://AUTH_TOKEN@screamshot.dev/screenshot?url=http://example.com&viewport=800,600&full=true&scale=2&prefers-reduced-motion=reduce
```

### URL

The URL to capture. The only required parameter.

```
url=http://example.com
```

### Window / viewport size

Control the size of the viewport with `WIDTH,HEIGHT`. Defaults to `1024,768`.

```
viewport=800,600
```

### Full-screen

Capture the entire page instead of just the viewport. Defaults to `false`.

```
full=true
```

### Scale

This mimics [`devicePixelRatio`](https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio) and scales the viewport so `scale=2` combined with `viewport=800,600` results in a 1600×1200 image. Defaults to `1`.

```
scale=2
```

### `prefers-reduced-motion`

Force the browser into [`prefers-reduced-motion=reduce`](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-reduced-motion) mode. This can be used as a standards-based hint to the page not to use animations. Defaults to nothing and so is not enabled.

```
prefers-reduced-motion=reduce
```

## Development

Start the server with `bundle exec puma -C config/puma.rb`.

Run the tests with `bundle exec rspec`.

Write usage docs here, update the homepage with `bin/update_docs`.

## Licence

Copyright © [Ben Pickles](http://www.benpickles.com), [MIT licence](LICENCE).
