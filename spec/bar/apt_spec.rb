require 'spec_helper'

describe package('apt') do
  it { should be_installed }
end

describe file('/etc/apt/sources.list') do
  it { should be_file }
  it { should contain "deb http://us.archive.ubuntu.com/ubuntu/ precise main restricted" }
end
