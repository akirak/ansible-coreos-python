Ansible Role for Python Support on CoreOS
=========

This is yet another Ansible role that installs Python onto your CoreOS machine. CoreOS doesn't have Python installed by default, which made Ansible nearly useless. To address this issue, this role downloads and extracts [portable-pypy](https://github.com/squeaky-pl/portable-pypy) to `/home/core/pypy`. It also installs pip, which allows you to install Python packages required by Ansible modules you need. There are already many solutions for the same purpose, but I failed to get them working, so I implemented one on my own. 

Installation
------------

Clone this repository to `roles` directory of your playbook, or use `ansible-galaxy`:

    ansible-galaxy install akirak.coreos-python

## Usage

Set `ansible_python_interpreter` to `/home/core/pypy/bin/pypy` in your inventory:

```
[core]
core-01

[core:vars]
ansible_ssh_user=core
ansible_python_interpreterr=/home/core/pypy/bin/pypy
```

If you are using Vagrant, your Vagrant file should include something like the following:

```
    config.vm.provision "ansible" do |ansible|
      ansible.verbose = true
      ansible.playbook = "sites.yml"
      ansible.extra_vars = {
        "ansible_python_interpreter" => "/home/core/pypy/bin/pypy",
        "ansible_user" => "core"
      }
    end
```

To make Python available before all the other things, your playbook should start as follows (`gather_facts: False` is necessary):

```
---
- hosts: core
  gather_facts: False
  roles:
    - akirak.coreos-python
# the rest of your playbook
...
```

pip is installed as `/home/core/pypy/bin/pip`. To install pip packages via Ansible, you have to set the path as `executable` parameter in a `pip` task:

```
- name: install docker-py for supporting Docker
  pip:
    name: docker-py
    executable: /home/core/pypy/bin/pip
```

License
-------

BSD

Author Information
------------------

Akira Komamura
