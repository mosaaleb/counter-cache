# frozen_string_literal: true

module CounterCache
  module HasCounterCache
    extend ActiveSupport::Concern

    included do
      class_attribute :counter_cached_columns, default: []
    end

    class_methods do
      def counter_for(*args)
        self.counter_cached_columns += self.counter_cached_columns | args
        class_eval do
          args.each do |arg|
            define_method "#{arg}_count" do
              "Grabbing count for #{arg}..."
            end
          end
        end
      end
    end
  end
end
