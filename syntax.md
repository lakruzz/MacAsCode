---
---

## Module: [homebrew_tap](http://docs.ansible.com/ansible/latest/homebrew_tap_module.html)

```yaml
  -
    module: homebrew_tap                 # [manadory]
    name:   <name of the tap to install> # [manadory]
    state:  <present|absent>             # [optional, default('present')]
    url:    <url to tap>                 # [optional (GitHub is assumed)]
```

## Module: [git_config](http://docs.ansible.com/ansible/latest/git_config_module.html)

```yaml
installs:
  -
    module: git_config                   # [manadory]
    name:   <name of attr to update>     # [manadory]
    scope:  <local|global|system>        # [optional, default('system')]
    repo:   <git repo>                   # [optional unless state=local]
    value:  <value to write>             # [mandatory]
```

## Module [gem](http://docs.ansible.com/ansible/latest/gem_module.html)

```yaml
installs:
  -
    module: gem
    name:   <name of the gem to install> # [mandatory]
    state:  <present|absent|latest>      # [optional, default('present')]
```

## Module [shell](http://docs.ansible.com/ansible/latest/shell_module.html)

```yaml
installs:
  -
    module:   shell
    name:     <header>                    # [optional]
    shell:    <command to run>            # [required]
    chdir:    <path>                      # [optional]
    creates:  <the file to test>          # [optional]
    removes:  <the file to test>          # [optional]
```

##  Module [homebrew](http://docs.ansible.com/ansible/latest/homebrew_module.html)

```yaml
installs:
  -
    module: homebrew
    name:   <name of the keg to install>  # [mandatory]
    state:  <present|absent|head|
              latest|linked|unlinked>     # [optional default('present')]
    update_homebrew: <yes|no>             # [optional, default('no')]
    upgrade_all: <yes|no>                 # [optional, default('no')]
```


## Module [homebrew_casks](http://docs.ansible.com/ansible/latest/homebrew_cask_module.html)

```yaml
installs:
  -
    module: homebrew_cask                  # [mandatory]
    name:   <name of the keg to install>   # [mandatory]
    state:  <present|absent>               # [optional default('present')]
```


## Module [lineinfile](http://docs.ansible.com/ansible/latest/lineinfile_module.html)

```yaml
installs:
  -
    module: lineinfile                     [mandatory]
    path:   <file to modify>               [mandatory]
    state:  <present|absent>               [optional default('present')]
    line:   <line to insert>               [optional - unless state=present]
    regexp: <regexp tp match>              [optional]
    insertafter: <no|yes>                  [optional | default('EOF')]
    backup: <no|yes>                       [optional | default('no')]
```
