# frozen_string_literal: true

module CounterCache
  ModelNotFound = Class.new(StandardError)

  ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                          database: 'db/development.sqlite3')

  class Migration
    def initialize(model_name)
      @model_name = model_name
      @counter_columns = model_name.constantize.counter_cached_columns
    rescue StandardError
      raise(ModelNotFound, "Couldn't find #{model_name} model")
    end

    def generate
      counter_columns.each do |column|
        generate_migration_file_for(column)
      end
    end

    private

    attr_reader :model_name, :counter_columns

    # def generate_migration_file_for(column)
    #   system 'cd test/dummy && rails g migration '\
    #          "add#{column.capitalize}sCountColumnTo#{model_name}s "\
    #          "#{column}_count:integer"
    # end

    def generate_migration_file_for(column)
      ActiveRecord::Schema.define do
        add_column :posts, "#{column}_count".to_s, :integer, default: 0
      end
    end
  end
end
