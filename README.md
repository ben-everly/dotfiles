# dotfiles

This is my personal dotfiles repository for ubuntu. I use rcm in conjunction with this repo to manage configurations for vim, bash, git and tmux.

## Installation

This may overwrite your currently existing configurations. For more info on rcm, you can view the man pages [here](http://thoughtbot.github.io/rcm/rcm.7.html).

```sh
# install software
sudo apt-get -y vim tmux git

# add repo to apt-get for rcm and install
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
sudo apt-get install rcm

# clone this repo into .dotfiles in your home directory
git clone https://github.com/ben-everly/dotfiles ~/.dotfiles

# copy configurations
rcup
```
