#!/usr/bin/env ruby
require 'json'
require 'base64'
require 'fileutils'

services = JSON.parse(ENV['VCAP_SERVICES'])['user-provided']

services.select do |service|
  service.['type'] == 'config_map' and service.has_key? 'files'
end.each do |service|
  service['files'].each do |file|
    file_path = file['path']
    FileUtils.mkdir_p File.dirname(file_path)
    File.open(file_path, 'w') do |f|
      format = file.fetch('format', 'plaintext')
      f.write case format
      when "plaintext"
        file['content']
      when "base64"
        Base64.decode64 file['content']
      end
    end
  end
end
