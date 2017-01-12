module Docker
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'docker/tasks/docker.rake'
    end
  end
end
