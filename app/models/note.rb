class Note < ApplicationRecord

  has_one_attached :note_image

  belongs_to :user

  #検索メソッド
  def self.search_for(content)
    Note.where('title LIKE ? OR contents LIKE ?', "%#{content}%", "%#{content}%")
  end

  #Action Textの使用
  has_rich_text :content

  validates :title, presence: true
  validates :contents, presence: true

end
