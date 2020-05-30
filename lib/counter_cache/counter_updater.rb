# frozen_string_literal: true

module CounterCache
  module CounterUpdater
    extend ActiveSupport::Concern

    included do
      parent_class = to_s.classify.constantize
      p parent_class
      counter_cached_columns.each do |counter_column|
        child_class = counter_column.to_s.classify.constantize
        child_class.class_eval do
          after_create "increment_#{counter_column}_count".to_sym
          after_destroy "decrement_#{counter_column}_count".to_sym

          define_method "increment_#{counter_column}_count" do
            SQL.new(parent_class, child_class).increment
          end

          define_method "decrement_#{counter_column}_count" do
            SQL.new(parent_class, child_class).decrement
          end
        end
      end
    end
  end
end
