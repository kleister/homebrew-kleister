# Gomematic: Homebrew

[![Build Status](http://github.dronehippie.de/api/badges/kleister/homebrew-kleister/status.svg)](http://github.dronehippie.de/kleister/homebrew-kleister)
[![Stories in Ready](https://badge.waffle.io/gomematic/gomematic-api.svg?label=ready&title=Ready)](http://waffle.io/gomematic/gomematic-api)
[![Join the Matrix chat at https://matrix.to/#/#gomematic:matrix.org](https://img.shields.io/badge/matrix-%23gomematic%3Amatrix.org-7bc9a4.svg)](https://matrix.to/#/#gomematic:matrix.org)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/2f2715f6b21d4203843e63fac80a442a)](https://www.codacy.com/app/kleister/homebrew-kleister?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=kleister/homebrew-kleister&amp;utm_campaign=Badge_Grade)


**This project is under heavy development, it's not in a working state yet!**

Homebrew repository to install Kleister on macOS.


## Prepare

```bash
brew tap kleister/kleister
```


## Install

### kleister-cli

```bash
brew install kleister-cli
kleister-cli -h
```

### kleister-api

```bash
brew install kleister-api
kleister-api -h
```

### kleister-ui

```bash
brew install kleister-ui
kleister-ui -h
```


## Development

```
rake test
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
Copyright (c) 2016 Thomas Boerger <thomas@webhippie.de>
```
