# frozen_string_literal: true

module CounterCache
  class ModelNotFound < StandardError
    def initialize(model_name)
      super()
      @model_name = model_name
    end

    def message
      "Couldn't find #{model_name} model"
    end

    private

    attr_reader :model_name
  end

  class MissingColumn < StandardError
    def initialize(model_name, column_name)
      super()
      @model_name = model_name
      @column_name = column_name
    end

    def message
      "No defind #{column_name} is defined in #{model_name}\n"\
      "Make sure to add counter_for: #{column_name} in #{model_name.classify}"
    end

    private

    attr_reader :model_name, :column_name
  end
end
