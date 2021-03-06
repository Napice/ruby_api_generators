require 'thor'

module RubyApiGenerators
  module Generators
    class Roda < Thor::Group
      include Thor::Actions

      argument :name
      class_option :test_framework

      def self.source_root
        File.join(File.dirname(__FILE__), '..', 'templates', 'roda')
      end

      def build_test_suite_folder
        empty_directory "#{name}/spec"
        copy_file 'spec/rspec.options', "#{name}/.rspec"
        template 'spec/spec_helper.rb.erb', "#{name}/spec/spec_helper.rb"
        copy_file 'spec/root_view_spec.rb', "#{name}/spec/root_view_spec.rb"
      end

      def copy_gemfile
        copy_file 'Gemfile', "#{name}/Gemfile"
      end

      def copy_licence
        copy_file 'LICENSE', "#{name}/LICENSE"
      end

      def copy_readme
        copy_file 'README.md', "#{name}/README.md"
      end

      def copy_config_ru
        copy_file 'config.ru', "#{name}/config.ru"
      end

      def copy_rakefile
        copy_file 'Rakefile', "#{name}/Rakefile"
      end

      def copy_env_file
        copy_file '.env', "#{name}/.env"
      end

      def set_up_application_folder
        build_application_folder
        build_models_folder
        build_routes_folder
        build_operations_folder
        build_tasks_folder
        build_config_folder
        build_db_folder
      end

      private

      def build_application_folder
        empty_directory "#{name}/application"
        copy_file 'application/api.rb', "#{name}/application/api.rb"
        copy_file 'application/api/api_support.rb', "#{name}/application/api/api_support.rb"
      end

      def build_config_folder
        empty_directory "#{name}/application/config"
        copy_file 'application/config/database.rb', "#{name}/application/config/database.rb"
        copy_file 'application/config/sequel.rb', "#{name}/application/config/sequel.rb"
      end

      def build_db_folder
        empty_directory "#{name}/application/db"
        copy_file 'application/db/migrations/20180930152809_add_user_table.rb',
                  "#{name}/application/db/migrations/20180930152809_add_user_table.rb"
        copy_file 'application/db/migrations/migration_template.rb',
                  "#{name}/application/db/migrations/migration_template.rb"
      end

      def build_models_folder
        empty_directory "#{name}/application/api/models"
        copy_file 'application/api/models/user.rb', "#{name}/application/api/models/user.rb"
      end

      def build_operations_folder
        empty_directory "#{name}/application/api/operations"
        copy_file 'application/api/operations/user_service.rb',
                  "#{name}/application/api/operations/user_service.rb"
      end

      def build_tasks_folder
        empty_directory "#{name}/application/tasks"
        copy_file 'application/tasks/db.rake',
                  "#{name}/application/tasks/db.rake"
      end

      def build_routes_folder
        empty_directory "#{name}/application/api/routes"
        copy_file 'application/api/routes/main.rb', "#{name}/application/api/routes/main.rb"
      end
    end
  end
end
