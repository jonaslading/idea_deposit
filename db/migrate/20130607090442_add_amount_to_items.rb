class AddAmountToItems < ActiveRecord::Migration
  def change
    add_column :items, :amount, :integer
  end
end
