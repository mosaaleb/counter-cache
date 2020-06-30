# frozen_string_literal: true

module CounterCache
  class Railtie < ::Rails::Railtie
    initializer 'include counter cache module to application record on load' do
      ActiveSupport.on_load(:active_record) do
        # Rails.configuration.to_prepare do
          ApplicationRecord.include CounterCache::HasCounterCache
        # end
      end
    end
  end
end
