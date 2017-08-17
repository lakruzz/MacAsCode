
# MacAsCode

**Configuring my Mac to the state I like it, coming from nowhere, using only executable code from this repo**





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


Run

```shell
./womm --manuscript manuscripts/default-mac.yml
# or simply

./womm --help
```

# The order in which task are executed

Tasks are executed in group by module - within each group, task are executed in the order they appear in the manuscript.

Different script may support different modules and execute them in different orders

* [macascode.yml](macascode.md)
* [ubuntuascode.yml](ubuntuascode.md)


### I want to run my own manuscript!

Use `default.yml` as an example, make your own copy, tweak it to your liking and run it like this:

```shell
ansible-playbook  macascode.yml --extra-vars "manuscript=manuscripts/marcommachine.yml"
```

# Syntax

The synax for the manuscritps are really simple, just remember:

1. This is yaml - so all files should start with an line containing noting but three dashes: `---`.
2. All files must defined the list named `installs`
3. Each item in `installs` has two mandatory items:
  - `module:[name-of-ansible-module-to-invoke]`
  - `parameters: [list-of-valid-parameters-to-the-module]`
4. Each item in `installs` has one optional item
  - `become: [yes|no]` (`no` is default).

Here's an example:

```yaml
---
installs:
  - module: lineinfile
    parameters:
      path:   /etc/paths
      state:  present
      regexp: /usr/local/bin
      insertafter: BOF
      line:   /usr/local/bin
    become: yes
```

It uses the module lineinfile to verify that the line `usr/local/bin` is present in the `/etc/paths` file - but if it isn't it will insert it at the beginning of the file. The fact that this requires SUDO privileges is enforced by the `become: yes`.


All modules are documented on docs.ansible.com using a format like this:

`http://docs.ansible.com/ansible/latest/<module-name-here>_module.html`

So the lineinfile module used in the example above is documented [here](http://docs.ansible.com/ansible/latest/lineinfile_module.html):

# Adding support for more Ansible modules:
This script supports a number of selected Ansible modules but it can easily be extended with adding
support for more - that should happen in the ansible playbook itself (E.g `macascode.yml` ).

Say you wanted to add support for the Apt package manager, so the script would also support Ubuntu users - this is how you would go about it:

## Find your module

Find the Ansible module to add support for.

So the documentation for the Apt module is here: http://docs.ansible.com/ansible/latest/apt_module.html

## Add a task for it

Add a snippet to the ansible playbook that looks like this:

```yaml
- name: Install using apt
  apt:
    "{{ item.parameters }}"
  become: "{{ item.become | default('false')}}"
  with_items: "{{ installs | selectattr('module', 'equalto', 'apt') | list }}"
```

The code snippet is the same for (almost) all modules - only two things are module specific:

1. Code is in line `2` where the key should be the name of the module to invoke.
2. The 3rd parameter to the `selectattr` filter in line `5` should also be changed to the new of the module.

## Create a manuscript

The rest happens in the _manuscripts_ which would have to do contain something specific to apt. It could be this:

```yaml
installs:
  - module: apt
    parameters:
      name:   git
```
It supports all the parameters available to the module and in addition it supports the task attribute `become: [yes|no]` (`no`is the default)

So according to the documentation of the Apt module you can even do something like this:

```yaml
installs:
  - module: apt
    parameters:
      name: git
      state: latest
      update_cache: yes
      upgrade: safe
    become: yes
```

# What about Linux?

**NOTE:** The good stuff in this repo assumes you are on a Mac like me.

But there is actually not a strict dependency to MacOS. The dependency is to the Homebrew package manager - which I'm using. Making this script work on Linux would be as simple as to replace the package manager with the one preferred to the OS.

I'v tried to illustrate the simplicity of this in the example above. I've even created a file  `ubuntuascode.yml` in which is removed the Homebrew specifics and added Apt and Apt_repository.

I haven't created manuscripts to go with it - but if you are a Linux user - give it a spin!
