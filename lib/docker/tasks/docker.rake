require 'docker'
require 'yaml'
require 'tempfile'
require 'pathname'


namespace :docker do

  desc 'Configure settings'
  task :config do |t, args|
    @docker_compose_file = write_tmp_yml_file(
      docker_compose_file,
      'docker-compose.yml',
      {
        "TMP_APP_NAME": app_name,
        "DOCKER_PREFIX": docker_prefix
      }
    )

    @docker_sync_file = write_tmp_yml_file(
      docker_sync_file,
      'docker-sync.yml',
      {
        "REPLACE_COMPOSE_FILE_PATH": @docker_compose_file.path,
        "REPLACE_PROJECT_PATH": Rails.root.to_s
      }
    )
  end

  desc 'Build'
  task :build => [:config] do |t, args|
    puts "--- Starting to build images ---"
    build_docker
  end

  desc 'Create'
  task :create => [:config] do |t, args|
    run_docker
  end

  desc 'Clean the docker containers'
  task :clean => [:config] do |t, args|
    clean_docker
  end

  desc 'Start the docker containers'
  task :up => [:config] do |t, args|
    run_docker
  end

  desc 'Start Docker Console'
  task :console, [:postfix] do |t, args|
    raise "Postfix of container name was not found. #{app_name}-[:postfix]. Run rake docker:console['postfix_name'], where postfix is the end part of your container (most likely, it will be 'project')" if args[:postfix].blank?

    container = Docker::Container.get("#{app_name}-#{args[:postfix]}")
    container.exec(['rails c'])
  end

  private

  def run_docker
    DockerSync.start(@docker_sync_file.path)
  end

  def build_docker
    Dir.glob("#{Rails.root}/config/docker/**/Dockerfile") do |path| # note one extra "*"
      dir = path.split('/')[-2]
      break if dir.blank?

      relative = relative_path(absolute_path(path))

      # Create an Image from a Dockerfile and stream the logs
      image = Docker::Image.build_from_dir("#{Rails.root}", { 'dockerfile' => "./#{relative.to_s}" }) do |v|
        begin
          v.split("\n").flatten.compact.each do |log|
            if (output = JSON.parse(log)) && output.has_key?("stream")
              $stdout.puts(output["stream"])
            end
          end
        rescue => e
          $stdout.puts("Could not output message")
        end
      end

      image.tag('repo' => "#{docker_prefix}/#{app_name}-#{dir}", force: true)
    end
  end

  def relative_path(path)
    path.relative_path_from(Rails.root)
  end

  def absolute_path(path)
    Pathname.new(File.expand_path(path))
  end

  def clean_docker
    DockerSync.clean(@docker_sync_file.path)
  end

  def load_yml_file(file_path)
    YAML.load_file(file_path)
  end

  def tmp_files
    @tmp_files ||= []
  end
  def remove_tmp_files
    tmp_files.each{|file| file.close; file.unlink}
  end

  def write_tmp_yml_file(content, file_name, replacements = {})
    file = Tempfile.new(file_name)

    new_content = content.to_yaml

    replacements.each do |k,v|
      new_content.gsub!(/#{k}/, "#{v}")
    end unless replacements.blank?

    file.write(new_content)
    file.rewind
    tmp_files << file
    file
    #file.read      # => "hello world"
    #file.close
    #file.unlink    # deletes the temp file
  end

  def docker_compose_file
    load_yml_file("#{Rails.root}/config/docker/compose/docker-compose.yml")
  end

  def docker_sync_file
    load_yml_file(Docker.config + "/docker/docker-sync.yml")
  end

  def docker_prefix
    ENV['DOCKER_PREFIX'] || 'prefix'
  end

  def app_name
    ENV['APP_NAME'] || 'application'
  end
end
