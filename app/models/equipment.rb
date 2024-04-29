class Equipment < ApplicationRecord

  has_one_attached :equipment_image

  belongs_to :user

  #検索メソッド
  def self.search_for(content)
    Equipment.where('name LIKE ? OR description LIKE ?', "%#{content}%", "%#{content}%")
  end

  validates :name, presence: true
  validates :description, presence: true
  validates :evaluation, presence: true

end
