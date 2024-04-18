class CreateRecipeComments < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_comments do |t|

      t.integer :user_id, null: false
      t.integer :recipe_id, null: false
      t.text :contents, null: false

      t.timestamps
    end
  end
end
