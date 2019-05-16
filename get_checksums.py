#!/usr/bin/env python

import requests
import yaml
import sys

VERSIONS = [
  '7.0.1',
  '7.0.0',
  '6.7.2',
  '6.7.1',
  '6.7.0',
  '6.6.2',
  '6.6.1',
  '6.6.0',
  '6.5.4',
  '6.5.3',
  '6.5.2',
  '6.5.1',
  '6.5.0',
  '6.4.3',
  '6.4.2',
  '6.4.1',
  '6.4.0',
  '6.3.2',
  '6.3.1',
  '6.3.0',
  '6.2.4',
  '6.2.3',
  '6.2.2',
  '6.2.1',
  '6.2.0',
  '6.1.4',
  '6.1.3',
  '6.1.2',
  '6.1.1',
  '6.1.0',
  '6.0.1',
  '6.0.0',
]

def get_checksum(version, type):
  if type == 'deb':
    url = "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-{}-amd64.deb.sha512".format(version)
  elif type == 'rpm':
    url = "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-{}-x86_64.rpm.sha512".format(version)
  r = requests.get(url)
  if r.status_code == 200:
    checksum = r.text.split(" ")[0]
    return "sha512:" + checksum
  else:
    print "failed to get: " + url
    sys.exit(1)

data = {
  'filebeat_deb_checksums': {},
  'filebeat_rpm_checksums': {}
}
for v in VERSIONS:
    data['filebeat_deb_checksums'][v] = get_checksum(v, 'deb')
    data['filebeat_rpm_checksums'][v] = get_checksum(v, 'rpm')

with open('vars/checksums.yml', 'w') as yaml_file:
    yaml.safe_dump(data, yaml_file, default_flow_style=False, explicit_start=True)
