# Ansible Role: filebeat

[![Build Status](https://travis-ci.org/bdclark/ansible-filebeat.svg?branch=master)](https://travis-ci.org/bdclark/ansible-filebeat)

Install/configure Elastic Filebeat

Tested Operating Systems and Ansible Versions
---------------------------------------------
This role is tested using Ansible 2.6, 2.7, and 2.8 on the operating systems shown below.
Other distributions and versions may work, YMMV.

- Ubuntu 18.04
- Ubuntu 16.04
- Centos 7
- Amazon Linux 2

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml) for a list and description of
variables used in this role.

Example Playbook
----------------

```yaml
- hosts: webservers
  become: true
  vars:
    filebeat_version: 6.6.1
    filebeat_fields:
      environment: prod
    filebeat_fields_group:
      purpose: frontend
    filebeat_tags:
      - webservers
    filebeat_config:
      output:
        logstash:
          hosts: ["logstash.example.com:5444"]
    filebeat_inputs:
      - paths:
          - /var/log/*.log
        input_type: log
    filebeat_modules:
      - module: system
        syslog:
          enabled: true
        auth:
          enabled: true
    filebeat_processors:
      - drop_event:
          when:
            contains:
              source: test
  roles:
    - role: filebeat
```
