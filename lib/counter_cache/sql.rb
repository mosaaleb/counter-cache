# frozen_string_literal: true

module CounterCache
  class SQL
    def initialize(parent_klass, child, counter_column)
      @parent_klass = parent_klass
      @child = child
      @counter_column = counter_column
    end

    def increment
      sql = "UPDATE #{parent_table} "\
            "SET #{counter_column}_count=#{counter_column}_count+1 "\
            "WHERE #{parent_klass.primary_key}=#{parent_id}"

      execute_sql(sql)
    end

    def decrement
      sql = "UPDATE #{parent_table} "\
            "SET #{counter_column}_count=#{counter_column}_count-1 "\
            "WHERE #{parent_klass.primary_key}=#{parent_id}"

      execute_sql(sql)
    end

    private

    attr_reader :parent_klass, :child, :counter_column

    def parent_table
      parent_klass.name.pluralize.downcase
    end

    def parent_id
      child.send("#{parent_table.singularize}_id")
    end

    def execute_sql(sql)
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
