# Kleister: Homebrew

[![Build Status](http://drone.kleister.tech/api/badges/kleister/homebrew-kleister/status.svg)](http://drone.kleister.tech/kleister/homebrew-kleister)
[![Stories in Ready](https://badge.waffle.io/kleister/kleister-api.svg?label=ready&title=Ready)](http://waffle.io/kleister/kleister-api)
[![Join the Matrix chat at https://matrix.to/#/#kleister:matrix.org](https://img.shields.io/badge/matrix-%23kleister%3Amatrix.org-7bc9a4.svg)](https://matrix.to/#/#kleister:matrix.org)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/2f2715f6b21d4203843e63fac80a442a)](https://www.codacy.com/app/kleister/homebrew-kleister?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=kleister/homebrew-kleister&amp;utm_campaign=Badge_Grade)

**This project is under heavy development, it's not in a working state yet!**

Homebrew repository to install [Kleister](https://kleister.tech) on macOS.


## Prepare

```bash
brew tap kleister/kleister
```


## Install

### [kleister-api](https://github.com/kleister/kleister-api)

```bash
brew install kleister-api
kleister-api -h
```

### [kleister-ui](https://github.com/kleister/kleister-ui)

```bash
brew install kleister-ui
kleister-ui -h
```

### [kleister-cli](https://github.com/kleister/kleister-cli)

```bash
brew install kleister-cli
kleister-cli -h
```


## Development

```bash
bundle install
bundle exec rake rubocop
bundle exec rake spec
```


## Security

If you find a security issue please contact kleister@webhippie.de first.


## Contributing

Fork -> Patch -> Push -> Pull Request


## Authors

* [Thomas Boerger](https://github.com/tboerger)


## License

Apache-2.0


## Copyright

```
Copyright (c) 2018 Thomas Boerger <thomas@webhippie.de>
```
