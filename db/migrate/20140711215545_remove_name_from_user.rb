class RemoveNameFromUser < ActiveRecord::Migration[4.2]
  def up
    remove_column :users, :name
  end
end
