#!/bin/bash

# Install requirements.
ansible-galaxy collection install -r requirements.yml

# Install everything!
ansible-playbook -K arch-setup.yml
