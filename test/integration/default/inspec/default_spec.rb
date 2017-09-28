describe service('filebeat') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/filebeat/filebeat.yml') do
  it { should be_file }
  it { should be_owned_by 'root' }
  its('mode') { should cmp '0644' }
end

describe file('/etc/filebeat/conf.d') do
  it { should be_directory }
end

describe file('/var/log/filebeat') do
  it { should be_directory }
end
