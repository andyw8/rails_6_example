class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.boolean :completed, null: false, default: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
