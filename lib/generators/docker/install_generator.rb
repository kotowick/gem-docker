require 'rails/generators'

module Docker
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc 'Creates docker config files.'

    class << self
      def template_file_paths_map
        # from gem directory path => to app directory path
        {
        }
      end

      def template_dir_paths_map
        # from gem directory path => to app directory path
        {
            'compose' => "#{Rails.root}/config/docker/docker-compose",
            'project' => "#{Rails.root}/config/docker/project",
            'database' => "#{Rails.root}/config/docker/database",
        }
      end
    end

    # Ordering of methods below defines order of operations

    def remove_template_files
      self.class.template_file_paths_map.each_pair do |_from, to|
        remove_file to
      end
    end

    def copy_template_files
      self.class.template_file_paths_map.each_pair do |from, to|
        copy_file from, to
      end
    end

    def copy_template_dirs
      self.class.template_dir_paths_map.each_pair do |from, to|
        directory from, to
      end
    end
  end
end
