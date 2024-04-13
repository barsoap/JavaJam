class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :contents, null: false

      t.timestamps
    end
  end
end
