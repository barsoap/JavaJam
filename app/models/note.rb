class Note < ApplicationRecord

  has_one_attached :note_image

  belongs_to :user

  #検索メソッド
  def self.search_for(content)
    Note.where('title LIKE ?', '%' + content + '%')
  end

  validates :title, presence: true
  validates :contents, presence: true

end
