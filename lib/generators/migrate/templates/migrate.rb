# frozen_string_literal: true

class <%= "add_#{column}_count_to_#{name}s".camelize %> < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def change
    add_column :<%= name.tableize %>, :<%= "#{column}_count" %>, :integer, default: 0
    add_index :<%= name.tableize %>, :<%= "#{column}_count" %>
  end
end
