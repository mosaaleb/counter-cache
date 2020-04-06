# frozen_string_literal: true

require 'active_support/concern'

module CounterCache
  module HasCounterCache
    extend ActiveSupport::Concern

    def counter_cached_columns
      @counter_cached_columns ||= []
    end
  end
end
