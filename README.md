# brew-cask-upgrade-all

like a brew upgrade for cask

## Installation

```sh
curl -O https://raw.githubusercontent.com/imasami/brew-cask-upgrade-all/v1.2.3/brew-cask-upgrade-all.rb
```
## Requirements

- macOS
- ruby

## Usage

```
$ brew-cask-upgrade-all [-f]

-f : force upgrade that newest version is 'latest'
```

```
# stdout log

brew update:
Already up-to-date.
brew upgrade:

hosts
latest  : 1.3
current : 1.3

iterm2
latest  : 3.0.8
current : 3.0.7
iterm2 updating..
==> Removing App: '/Applications/iTerm.app'
==> Satisfying dependencies
complete
==> Downloading https://iterm2.com/downloads/stable/iTerm2-3_0_8.zip
==> Verifying checksum for Cask iterm2
==> Moving App 'iTerm.app' to '/Applications/iTerm.app'
🍺  iterm2 was successfully installed!
iterm2 updated !!!

java
latest  : 1.8.0_102-b14
current : 1.8.0_102-b14

...

( something upgrade casks , also need your su password. )

...

brew cleanup:

brew cask cleanup:
==> Removing cached downloads
Nothing to do

all of done.
```

## Support

nop, DIY.

## Contributing

Fork the project, create a new branch, make your changes, and open a pull request.

## Development

- framework
  - nop



