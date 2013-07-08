class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :user
      t.int :color_id

      t.timestamps
    end
  end
end
