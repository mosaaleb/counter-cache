# frozen_string_literal: true

module CounterCache
  class Railtie < ::Rails::Railtie
    initializer 'counter cache' do
      ActiveSupport.on_load(:active_record) do
        ApplicationRecord.include CounterCache::HasCounterCache
      end
    end
  end
end
