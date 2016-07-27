#!/usr/bin/env ruby

# This is designed to be run on builds.delivery.puppetlabs.net
#   Find all the el7 rpms, output their filelist. (skip links and directories)
#   Output them as json for easier usage elsewhere.

require 'json'

holder = []
Dir["/opt/jenkins-builds/puppet-agent/1.*/repos/el/7/PC1/x86_64"].sort.each  do |dir|
  version = dir.split("/")[4]
  Dir["#{dir}/p*"].each do |rpm|
    str = `rpm -qpvl #{rpm}`
    str.each_line do |line|
      ln = line.split
      fl = {}
      unless ln[0][0] == "l" or ln[0][0] == "d"
        fl[:name] = ln[-1]
        fl[:size] = ln[4]
        fl[:version] =  version
        holder << fl
      end
    end
  end
end
puts holder.to_json
