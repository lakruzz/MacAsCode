---
url: http://www.nickhammond.com/automating-development-environment-ansible/
---
**Assuming you are on a Mac like me**

## Install brew

`homebrew-cask` is also needed, but is's included in brew.

```shell
# Install Brew as recommended on https://brew.sh/
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Install Ansible

```shell
brew install ansible
```


## Make a local Ansible folder for configurations

```shell
mkdir ~/.ansible
```
