class AddProgressToPost < ActiveRecord::Migration
  def change
    add_column :posts, :progress, :int
  end
end
