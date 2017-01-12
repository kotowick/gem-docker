module Docker
  class Docker_Api
    # Load the libraries from the other gem called 'docker-api'
    spec = Gem::Specification.find_by_name 'docker-api'
    require "#{spec.gem_dir}/lib/docker.rb"
    require "#{spec.gem_dir}/lib/docker/version.rb"
  end
end
