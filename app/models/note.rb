class Note < ApplicationRecord

  has_one_attached :note_image

  belongs_to :user

  def self.search_for(content, method) #検索メソッド
    if method == 'perfect'
      Note.where(title: content)
    elsif method == 'forward'
      Note.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Note.where('title LIKE ?', '%' + content)
    else
      Note.where('title LIKE ?', '%' + content + '%')
    end
  end

  validates :title, presence: true
  validates :contents, presence: true

end
