class Equipment < ApplicationRecord

  has_one_attached :note_image

  belongs_to :user
end
