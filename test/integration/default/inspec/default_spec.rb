describe service('filebeat') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/filebeat/filebeat.yml') do
  it { should be_file }
  it { should be_owned_by 'root' }
  its('mode') { should cmp '0600' }
end

describe file('/var/lib/filebeat') do
  it { should be_directory }
end

describe file('/var/log/filebeat') do
  it { should be_directory }
end

describe command('filebeat test config -c /etc/filebeat/filebeat.yml') do
  its('exit_status') { should eq 0 }
end

describe yaml('/etc/filebeat/filebeat.yml') do
  # verify name, tags, and fields
  its('name') { should eq 'myhost' }
  its(['tags', 0]) { should eq 'foobar' }
  its(['tags', 1]) { should eq 'webservers' }
  its(%w(fields myglobalkey)) { should eq 'myglobalvalue' }
  its(%w(fields environment)) { should eq 'test' }
  # verify filebeat inputs
  its(['filebeat', 'inputs', 0, 'enabled']) { should eq false }
  its(['filebeat', 'inputs', 1, 'paths', 0]) { should eq '/var/log/filebeat/*.log' }
  # verify modules
  its(['filebeat', 'modules', 0, 'module']) { should eq 'system' }
  its(['filebeat', 'modules', 0, 'auth', 'enabled']) { should eq true }
  # verify processors
  its(['processors', 0, 'drop_event', 'when', 'contains', 'source']) { should eq 'test' }
  # verify output
  its(%w(output file filename)) { should eq 'filebeat' }
  its(%w(output file path)) { should eq '/tmp/filebeat' }
end
