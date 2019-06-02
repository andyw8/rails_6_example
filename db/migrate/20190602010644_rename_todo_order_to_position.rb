class RenameTodoOrderToPosition < ActiveRecord::Migration[6.0]
  def change
    rename_column :todos, :order, :position
  end
end
