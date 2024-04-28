class CreateEquipment < ActiveRecord::Migration[6.1]
  def change
    create_table :equipment do |t|

      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.float :evaluation, default: 0

      t.timestamps
    end
  end
end
