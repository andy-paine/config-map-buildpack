#!/usr/bin/env ruby
require 'json'
require 'fileutils'

services = JSON.parse(ENV['VCAP_SERVICES'])['user-provided']

services.select do |service|
  service.has_key? 'files'
end.each do |service|
  service['files'].each do |file|
    file_path = file['path']
    FileUtils.mkdir_p File.dirname(file_path)
    File.open(file_path, 'w') do |f|
      f.write file['content']
    end
  end
end
