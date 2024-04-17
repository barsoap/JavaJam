class Recipe < ApplicationRecord

  has_one_attached :recipe_image

  belongs_to :user
  has_many :recipe_processes, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy

  accepts_nested_attributes_for :recipe_processes, reject_if: :all_blank, allow_destroy: true

  def self.search_for(content,method) #検索メソッド
    if method == 'perfect'
      Recipe.where(title: content)
    elsif method == 'forward'
      Recipe.where('title LIKE?', content + '%')
    elsif method == 'backword'
      Recipe.where('title LIKE ?', '%' + content)
    else
      Recipe.where('title LIKE ?', '%' + content + '%')
    end
  end

end
