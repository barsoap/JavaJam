class Recipe < ApplicationRecord

  has_one_attached :recipe_image

  belongs_to :user

end
