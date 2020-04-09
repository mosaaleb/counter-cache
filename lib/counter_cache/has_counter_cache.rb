# frozen_string_literal: true

require 'active_support/concern'

module CounterCache
  module HasCounterCache
    extend ActiveSupport::Concern

    included do |base|
      base.class_eval do
        @counter_cached_columns = []
      end
    end

    class_methods do
      def counter_cached_columns
        @counter_cached_columns ||= []
      end
    end
  end
end
