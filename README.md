# Cameron's Dotfiles

These are my dotfiles. There are many like it, but these are mine.

These dotfiles use [yadm](https://yadm.io/) to manage and bootstrap dotfiles
into a user's $HOME directory, as well as bootstrapping a system for new
installs (Ubuntu, Mac, and Centos supported).

Bootstrapping is done through Ansible. This is kind of janky, but I like keeping
the dotfiles actually just checked in with yadm, and have the bootstrapping
logic moved into ansible tasks that I can better control how they run on
different machines.

# Bootstrapping a new machine

**NOTE: This WILL overwrite all your dotfiles. This should only probably be done
by me for my own machines**

## Prerequisites

Git and Curl are prerequisites for running the bootstrap script. Get them onto
your machine someway.

If you're going to want to make changes to these dotfiles, you'll need to create
a new ssh key, and copy that to sr.ht to clone the repo over ssh.

## Cloning

1. `curl -L bootstrap.yadm.io | bash`
2. Choose `4. Other`
3. https://git.sr.ht/~cwill/dotfiles
2. `source <(curl -L bootstrap.yadm.io)`

