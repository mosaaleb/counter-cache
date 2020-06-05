# frozen_string_literal: true

class AddOpinionsCountAndApprovesCountToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :approves_count, :integer, default: 0
    add_column :posts, :opinions_count, :integer, default: 0
  end
end
