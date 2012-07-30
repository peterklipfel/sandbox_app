class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :id

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
