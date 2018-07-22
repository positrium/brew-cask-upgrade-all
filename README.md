# brew-cask-upgrade-all

like a brew upgrade for cask. [see also](https://qiita.com/positrium/items/3ac014f175955941ccb3).

## Installation

```sh
curl -O https://raw.githubusercontent.com/positrium/brew-cask-upgrade-all/v1.3.4/brew-cask-upgrade-all.rb
```
## Requirements

- macOS
- ruby

## Usage

```
$ ./brew-cask-upgrade-all.rb -h
usage:
  upgrade brew and brew casks.

  -h , --help     : this help message.
  --force         : force upgrade that newest version is "latest" or "auto_updates".
  -d , --dry-run  : dry run ( not includes "latest" and "auto_updates" ) but execute brew update, brew cleanup.
  --force-dry-run : dry run ( includes "latest" and "auto_updates" ) but execute brew update, brew cleanup.
  -c , --count    : count updatable casks. for bitbar plugin: https://github.com/positrium/bitbar-brew-cask-upgrade-all
```

```
# stdout log

brew update:
Already up-to-date.
brew cleanup:

brew cask upgrade:
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

## see also

- [bitbar plugin](https://github.com/positrium/bitbar-brew-cask-upgrade-all)

