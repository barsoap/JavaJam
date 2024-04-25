class CreateRecipeBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true
      t.timestamps
    end
  end
end
