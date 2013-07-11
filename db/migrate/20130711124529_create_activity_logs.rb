class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.string :user
      t.string :activity
      t.string :ip_address

      t.timestamps
    end
  end
end
