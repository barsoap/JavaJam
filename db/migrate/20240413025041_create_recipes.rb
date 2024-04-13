class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :contents, null: false
      t.float :evaluation, null: false

      t.timestamps
    end
  end
end
