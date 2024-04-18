class CreateRecipeProcesses < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_processes do |t|

      t.integer :recipe_id, null: false
      t.string :process, null: false
      t.text :description

      t.timestamps
    end
  end
end
