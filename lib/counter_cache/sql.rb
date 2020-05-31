# frozen_string_literal: true

module CounterCache
  class SQL
    def initialize(parent_class, child_class, parent_id, counter_column)
      @parent_class = parent_class
      @child_class = child_class
      @parent_id = parent_id
      @counter_column = counter_column
    end

    def increment
      parent_instance.update(column_name: parent_class.column_name + 1)
    end

    def decrement
      parent_instance.update(column_name: parent_class.column_name - 1)
    end

    private

    def column_name
      "#{counter_column}_count".to_sym
    end

    def parent_instance
      parent_class.find(parent_id)
    end

    attr_reader :parent_class, :child_class, :parent_id, :counter_column
  end
end
