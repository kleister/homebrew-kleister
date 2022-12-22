# Kleister: Homebrew

[![General Workflow](https://github.com/kleister/homebrew-kleister/actions/workflows/general.yml/badge.svg)](https://github.com/kleister/homebrew-kleister/actions/workflows/general.yml) [![Join the Matrix chat at https://matrix.to/#/#kleister:matrix.org](https://img.shields.io/badge/matrix-%23kleister%3Amatrix.org-7bc9a4.svg)](https://matrix.to/#/#kleister:matrix.org) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/ba764ae23b89464c98160567bbfb04f8)](https://www.codacy.com/gh/kleister/homebrew-kleister/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=kleister/homebrew-kleister&amp;utm_campaign=Badge_Grade)

Homebrew repository to install [Kleister](https://kleister.eu) on macOS.

## Prepare

```console
brew tap kleister/kleister
```

## Install

### [kleister-api](https://github.com/kleister/kleister-api)

```console
brew install kleister-api
kleister-api -h
```

### [kleister-ui](https://github.com/kleister/kleister-ui)

```console
brew install kleister-ui
kleister-ui -h
```

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

If you find a security issue please contact
[kleister@webhippie.de](mailto:kleister@webhippie.de) first.

## Contributing

Fork -> Patch -> Push -> Pull Request

## Authors

-   [Thomas Boerger](https://github.com/tboerger)

## License

Apache-2.0

## Copyright

```console
Copyright (c) 2018 Thomas Boerger <thomas@webhippie.de>
```
