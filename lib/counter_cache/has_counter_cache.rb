# frozen_string_literal: true

module CounterCache
  module HasCounterCache
    extend ActiveSupport::Concern

    included do
      class_attribute :counter_cached_columns, default: []
    end

    class_methods do
      def counter_for(counter_column)
        self.counter_cached_columns |= [counter_column]

        parent_klass = self
        parent_table = parent_klass.name.pluralize.downcase
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
