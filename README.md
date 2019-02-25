# filebeat

Install/configure Elastic Filebeat

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
