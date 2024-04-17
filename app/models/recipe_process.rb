class RecipeProcess < ApplicationRecord
  belongs_to :recipe
  has_one_attached :recipe_process_image
end
