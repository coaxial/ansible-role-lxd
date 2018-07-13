import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_lxd_install(host):
    lxd_pkg = host.package("lxd")
    lxdclient_pkg = host.package("lxd-client")

    assert lxd_pkg.is_installed
    assert lxdclient_pkg.is_installed
    assert lxd_pkg.version.startswith("3.")
    assert lxdclient_pkg.version.startswith("3.")


def test_lxd_enabled(host):
    lxd_svc = host.service("lxd")

    assert lxd_svc.is_enabled
    assert lxd_svc.is_running
