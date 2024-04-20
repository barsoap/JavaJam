class Tag < ApplicationRecord

  has_many :recipe_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :recipes, through: :recipe_tags

end
