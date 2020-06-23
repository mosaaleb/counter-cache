# frozen_string_literal: true

require 'rails/generators'

module CounterCache
  module Generators
    class AddCountersGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      source_root File.expand_path('templates', __dir__)
      argument :column, type: :string, required: true

      def generate_migration_file
        raise ModelNotFound.new(name) if model_not_found
        raise MissingColumn.new(name, column) if missing_column

        migration_template 'migrate.rb',
                           "db/migrate/add_#{column}_count_to_#{name}s.rb"
      end

      def self.next_migration_number(dirname)
        next_migration_number = current_migration_number(dirname) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end

      private

      def model_not_found
        Object.const_defined?(name.classify) == false
      end

      def missing_column
        !name.classify.constantize.counter_cached_columns.include? column.to_sym
      end
    end
  end
end
