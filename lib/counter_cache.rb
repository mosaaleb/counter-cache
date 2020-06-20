# frozen_string_literal: true

require 'counter_cache/railtie'
require 'counter_cache/has_counter_cache'
require 'counter_cache/migration'
require 'counter_cache/counter_updater'
require 'counter_cache/sql'
require 'generators/migrate/add_counters_generator'

module CounterCache
end
