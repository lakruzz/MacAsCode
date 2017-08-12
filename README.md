
# MacAsCode
Configuring my Mac to the state I like it, coming from nowhere, using only executable code from this repo.

**The good stuff in this repo assumes you are on a Mac like me**

The repo contains an Ansible play-book that is easy to run and configure. The process has three steps

1. Install dependencies to run Ansible
2. Run the play-book
3. Configure your new toolstack

Currently 1) and 3) are still manual - but my intension is to nail them too.

## Install pre-dependencies

The Ansible play-book obviously requires _Ansible_ to be installed to work. But it also requires
the Mac de facto default package management system _Homebrew_ to be installed.

Homebrew has a sub command `brew doctor` which will let you know if your Homebrew setup is good.  so a fail safe bootstrap for this repo could look like this (copy and paste into your terminal):

```shell
brew doctor || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

If it runs, you will have to login to use `sudo`.

Next; the `brew list ...` command will return an error if the keg queried isn't installed - so Ansible will install safely running this command:

```shell
brew doctor && brew list ansible || brew install ansible
```

### Get a copy of this repo

If you have git installed you can go:

```shell
mkdir -p ~/GitHub/lakruzz
cd ~/GitHub/lakruzz
git clone https://github.com/lakruzz/MacAsCode.git
cd MacAsCode
```

If you don't have git yet - then just download the zipped archive

```shell
cd ~/Downloads
curl -fsSL https://github.com/lakruzz/MacAsCode/archive/master.zip -o MacAsCode.zip
unzip -o MacAsCode.zip
cd MacAsCode-master
```

## Run the default manuscript

```shell
ansible-playbook macascode.yml
```
It will run the manuscript defined in `./manuscripts/default.yml`.

Or even simpler - if you have cloned the repo (as opposed to dowloaded the `.zip`)
```shell
./update
```

### I want to run my own manuscript!

Use `default.yml` as an example, make your own copy, tweak it to your liking and run it like this:

```shell
ansible-playbook  macascode.yml --extra-vars "manuscript=manuscripts/marcommachine.yml"
```


## Configure


```shell
GITHUB_NAME="Full name"
GITHUB_EMAIL="Git-Email@email.com"
GTIHUB_HANDLE="Github Username"
git phlow mkalias
git config --global user.name "$GITHUB_NAME"
git config --global user.email "$GITHUB_EMAIL"
git config --global merge.tool opendiff
git config --global github.user $GITHUB_HANDLE
ghi config --auth $GITHUB_HANDLE
```

# Syntax

This script supports a number of selected Ansible modules and in a selected scope of their capacity.

You should write your own manuscript for the playbook using the syntax described [here](syntax.md) 
