# ubuntuascode.yml

Supports the following modules - executed in the following order

* [apt_repository](http://docs.ansible.com/ansible/latest/apt_repository_module.html)
* [apt](http://docs.ansible.com/ansible/latest/apt_module.html)
* [gem](http://docs.ansible.com/ansible/latest/gem_module.html)
* [shell](http://docs.ansible.com/ansible/latest/shell_module.html)
* [git_config](http://docs.ansible.com/ansible/latest/git_config_module.html)
* [lineinfile](http://docs.ansible.com/ansible/latest/lineinfile_module.html)


Default manuscript is `manuscripts/default-ubuntu.yml`.

Execute with you own manuscript like this

```shell
ansible-playbook  ubuntuascode.yml --extra-vars "manuscript=manuscripts/my-manus.yml"
```
