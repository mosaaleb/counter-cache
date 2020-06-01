# frozen_string_literal: true

# TODO: data clumping parent_klass, child_klass

module CounterCache
  module CounterUpdater
    extend ActiveSupport::Concern

    included do
      parent_klass = self
      parent_table = parent_klass.name.pluralize.downcase
      counter_cached_columns.each do |counter_column|
        child_klass = counter_column.to_s.classify.constantize
        child_klass.class_eval do
          after_create "increment_#{parent_table}_#{counter_column}_count".to_sym
          after_destroy "decrement_#{parent_table}_#{counter_column}_count".to_sym

          define_method "increment_#{parent_table}_#{counter_column}_count" do
            SQL.new(parent_klass, self, counter_column).increment
          end

          define_method "decrement_#{parent_table}_#{counter_column}_count" do
            SQL.new(parent_klass, self, counter_column).decrement
          end
        end
      end
    end
  end
end
