# brew-cask-upgrade-all

# usage

```
$ brew-cask-upgrade-all

brew cask update:
Already up-to-date.
brew upgrade:

appcleaner
latest  : 3.3
current : 3.3

( something upgrade cask , also need your su password. )
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


