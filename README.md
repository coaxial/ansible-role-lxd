LXD Ansible role
=========

This is a role to install LXD on a host.

Requirements
------------

A Ubuntu host with Python. Tested with 16.04/Xenial, 17.10/Artful, 18.04/Bionic, 18.10/Cosmic.

Role Variables
--------------

Name | Default | Possible values | Description
---|---|---|---
`lxd__config_daemon_enable` | `false` | `true` or `false` | Whether the daemon is remotely accessible or not; `lxd__config_core_https_address` and `lxd__config_core_trust_password` must be set if this is `true`
`lxd__config_core_https_address` | none | any valid IP address | Sets the `core.https_address` variable in the [server configuration](https://lxd.readthedocs.io/en/latest/server/)
`lxd__config_core_trust_password` | none | any string | Sets the `core.trust_password` variable in the [server configuration](https://lxd.readthedocs.io/en/latest/server/)
`lxd__config_storage_driver` | `dir` | any valid storage backend | cf. [list of supported backends](https://lxd.readthedocs.io/en/latest/storage/#storage-backends-and-supported-functions)
`lxd__config_storage_source` | `/var/lib/lxd/storage-pools/default` | any valid path or dataset if using zfs | cf. the `source` variable for [storage configuration](https://lxd.readthedocs.io/en/latest/storage/#storage-configuration)
`lxd__config_network_ipv4_address` | `auto` | `auto`, `none`, CIDR IPv4 | Sets the `ipv4.address`, cf. [network configuration](https://lxd.readthedocs.io/en/latest/networks/)
`lxd__config_network_ipv6_address` | `auto` | `auto`, `none`, CIDR IPv6 | Sets the `ipv6.address`, cf. [network configuration](https://lxd.readthedocs.io/en/latest/networks/)

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in
regards to parameters that may need to be set for other roles, or variables that
are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: ansible-role-lxd, x: 42 }

License
-------

BSD

Author Information
------------------

Coaxial <[64b.it](https://64b.it)>
