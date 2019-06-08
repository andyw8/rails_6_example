class AddListToItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :list, null: false, foreign_key: true
  end
end
