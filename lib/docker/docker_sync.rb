require 'thor'
require 'docker-sync/update_check'

module Docker
  class Docker_Sync

    # Load the libraries from the docker-sync gem
    spec = Gem::Specification.find_by_name 'docker-sync'
    load "#{spec.gem_dir}/tasks/stack/stack.thor"

    def start(path)
      Thor::Stack.start ["start", "-c=#{path}"]
    end

    def clean(path)
      Thor::Stack.start ["clean", "-c=#{path}"]
    end
  end
end
