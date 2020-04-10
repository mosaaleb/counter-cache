# frozen_string_literal: true

module CounterCache
  module HasCounterCache
    def self.included(base)
      base.class_eval do
        @counter_cached_columns = []
      end

      base.extend ClassMethods
    end

    module ClassMethods
      attr_reader :counter_cached_columns

      def inherited(model)
        HasCounterCache.included(model)
      end
    end
  end
end
