#!/bin/bash

virt-builder debian-12 --format qcow2 --output ctf-server1.qcow2 --run install-server1.sh --network -v -x --root-password 'password:Passw0rd'
virt-builder debian-12 --format qcow2 --output ctf-server2.qcow2 --run install-server2.sh --network -v -x --root-password 'password:Passw0rd'
