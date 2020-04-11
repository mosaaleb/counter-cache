# frozen_string_literal: true

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require_relative '../test/dummy/config/environment'
ActiveRecord::Migrator.migrations_paths =
  [File.expand_path('../test/dummy/db/migrate', __dir__)]

require 'rails/test_help'

# Filter out the backtrace from minitest
# while preserving the one from other libraries.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

require 'rails/test_unit/reporter'
Rails::TestUnitReporter.executable = 'bin/test'

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path('fixtures', __dir__)

  ActionDispatch::IntegrationTest.fixture_path =
    ActiveSupport::TestCase.fixture_path

  ActiveSupport::TestCase.file_fixture_path =
    ActiveSupport::TestCase.fixture_path + '/files'

  ActiveSupport::TestCase.fixtures :all
end

require 'database_cleaner/active_record'
DatabaseCleaner.strategy = :truncation

class Minitest::Test
  def before_setup
    DatabaseCleaner.start
  end

  def after_teardown
    DatabaseCleaner.clean
    p "inside teardown #{Post.counter_cached_columns}"
    Post.counter_cached_columns = []
    p "inside teardown #{Post.counter_cached_columns}"
  end
end
