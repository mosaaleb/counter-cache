# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_200_406_194_809) do
  create_table 'posts', force: :cascade do |t|
    t.string 'text'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end
end
