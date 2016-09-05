# brew-cask-upgrade-all

# usage

```
$ brew-cask-upgrade-all

brew cask update:
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
```

# What is this doing

1. `brew cask update`
1. `brew upgrade `
1. check latest version of cask items. `uninstall --force` and `install` that have update version.
1. `brew cleanup`
1. `brew cask cleanup`


