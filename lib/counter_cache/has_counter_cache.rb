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
        include CounterCache::CounterUpdater
      end
    end
  end
end
