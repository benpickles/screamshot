# Screamshot

[![CI](https://github.com/benpickles/screamshot/actions/workflows/tests.yml/badge.svg)](https://github.com/benpickles/screamshot/actions/workflows/tests.yml)

![Screamshot logo](docs/logo.png)

A synchronous screenshot service built on Sinatra and headless Chrome (via Ferrum).

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/benpickles/screamshot)

## Usage

```sh
$ curl "http://AUTH_TOKEN@screamshot.dev/screenshot?url=http://example.com" > screenshot.png
```

## Development

Start the server with `bundle exec puma -C config/puma.rb`.

Run the tests with `bundle exec rspec`.

## Licence

Copyright © [Ben Pickles](http://www.benpickles.com), [MIT licence](LICENCE).
