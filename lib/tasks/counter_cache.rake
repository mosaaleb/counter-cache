# frozen_string_literal: true

require 'counter_cache/migration'

namespace :counter_cache do
  desc 'generate cached column migrations for specific model'
  task :generate_migration do
    task(ARGV[1].to_sym {})
    CounterCache::Migration.new(ARGV[1].camelize).generate
  end
end
