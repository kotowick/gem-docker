require "docker/version"
require 'docker/docker_sync'
require 'docker/docker_api'

module Docker
  require 'docker/railtie' if defined?(Rails::Railtie)

  def self.root
    File.dirname __dir__
  end

  def self.bin
    File.join root, 'bin'
  end

  def self.lib
    File.join root, 'lib'
  end

  def self.config
    File.join root, 'config'
  end
end

DockerSync = Docker::Docker_Sync.new
DockerApi = Docker::Docker_Api.new
