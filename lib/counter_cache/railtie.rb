# frozen_string_literal: true

module CounterCache
  class Railtie < ::Rails::Railtie
    initializer 'include counter cache module to application record on load' do
      ActiveSupport.on_load(:active_record) do
        ApplicationRecord.include CounterCache::HasCounterCache
      end
    end

    rake_tasks do
      load 'tasks/counter_cache.rake'
    end
  end
end
