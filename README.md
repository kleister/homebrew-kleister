# Kleister: Homebrew

[![General Workflow](https://github.com/kleister/homebrew-kleister/actions/workflows/general.yml/badge.svg)](https://github.com/kleister/homebrew-kleister/actions/workflows/general.yml) [![Join the Matrix chat at https://matrix.to/#/#kleister:matrix.org](https://img.shields.io/badge/matrix-%23kleister%3Amatrix.org-7bc9a4.svg)](https://matrix.to/#/#kleister:matrix.org)

Homebrew repository to install [Kleister](https://kleister.eu) on macOS.

## Prepare

```console
brew tap kleister/kleister
```

## Install

### [kleister-cli](https://github.com/kleister/kleister-cli)

```console
brew install kleister-cli
kleister-cli -h
```

## Development

```console
bundle install
bundle exec rake rubocop
bundle exec rake spec
```

## Security

If you find a security issue please contact kleister@webhippie.de first.

## Contributing

Fork -> Patch -> Push -> Pull Request

## Authors

*   [Thomas Boerger](https://github.com/tboerger)

## License

Apache-2.0

## Copyright

```console
Copyright (c) 2018 Thomas Boerger <thomas@webhippie.de>
```
