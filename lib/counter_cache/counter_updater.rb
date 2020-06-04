# frozen_string_literal: true

module CounterCache
  module CounterUpdater
    def self.for(column_name, parent_klass)
      parent_table = parent_klass.name.pluralize.downcase

      Module.new do
        extend ActiveSupport::Concern

        included do
          after_create "increment_#{parent_table}_#{column_name}_count".to_sym
          after_destroy "decrement_#{parent_table}_#{column_name}_count".to_sym
        end

        define_method "increment_#{parent_table}_#{column_name}_count" do
          SQL.new(parent_klass, self, column_name).increment
        end

        define_method "decrement_#{parent_table}_#{column_name}_count" do
          SQL.new(parent_klass, self, column_name).decrement
        end
      end
    end
  end
end
