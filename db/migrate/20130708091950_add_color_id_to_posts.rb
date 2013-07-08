class AddColorIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :color_id, :int
  end
end
