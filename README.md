# Marcel's dotfiles
This is just my dotfile repo.

## installation
At the moment there's no install script. This is still work in progress.
Nevertheless you could easily clone the repo:
```
git clone https://github.com/marcelhuth/Dotfiles.git
```
For me it works best to just link the files manually from e.g. ~/.bash_profile
to the local repo files:
```
ln -s ~/Dotfiles/bash_profile ~/.bash_profile
```
There will be an installation script doing all the hard work later ;)
## work in progress
I use solarized colors in iTerm and Gnome terminal as well as several editors across multiple operating systems. The color schemes came from [github](https://github.com/altercation/solarized) as well. This will be included in the repo at a later point to have all settings in one single place.
## notes about vim-airline usage
vim-airline needs a patched font to work correct with my settings. This is because of the use of powerline fonts.
Please check [vim-airline](https://github.com/bling/vim-airline) on github for details.
I use "Hack" on MacOS X in iTerm2 which works perfectly fine for me.
## credentials
Even when not forked the whole stuff most parts are from other excellent
dotfile-repos on github. Please see those for more details:

- [trulleberg](https://github.com/trulleberg/Dotfiles)
- [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
- [holman](https://github.com/holman/dotfiles)
