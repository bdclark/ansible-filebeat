describe service('filebeat') do
  it { should be_installed }
end

describe package('filebeat') do
  it { should be_installed }
end

describe file('/etc/filebeat/filebeat.yml') do
  it { should be_file }
end
