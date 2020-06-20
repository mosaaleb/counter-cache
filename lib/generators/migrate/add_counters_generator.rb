# frozen_string_literal: true

require 'rails/generators'

module CounterCache
  module Generators
    class AddCountersGenerator < Rails::Generators::NamedBase
      argument :column, type: :string, required: true

      def generate_migration_file
        if model_not_found
          raise(ModelNotFound, "Coudn't find #{name} model")
        end
      end

      private

      def model_not_found
        Object.const_defined?(name.classify) == false
      end
    end
  end
end
