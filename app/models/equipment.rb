class Equipment < ApplicationRecord

  has_one_attached :equipment_image

  belongs_to :user

  def self.search_for(content,method) #検索メソッド
    if method == 'perfect'
      Equipment.where(name: content)
    elsif method == 'forward'
      Equipment.where('name LIKE?', content + '%')
    elsif method == 'backword'
      Equipment.where('name LIKE ?', '%' + content)
    else
      Equipment.where('name LIKE ?', '%' + content + '%')
    end
  end

  validates :name, presence: true
  validates :description, presence: true
  validates :evaluation, presence: true

end
