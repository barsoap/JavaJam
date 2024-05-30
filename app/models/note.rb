class Note < ApplicationRecord

  has_one_attached :note_image

  belongs_to :user

  #検索メソッド
  def self.search_for(content)
    # Note
    # .joins("INNER JOIN action_text_rich_texts ON action_text_rich_texts.record_id = notes.id AND action_text_rich_texts.record_type = 'Note'").to_sql

    #SQL文で内部結合して、直接NoteモデルのデータとActionTextのデータのidが同じものを取得
    notes = ActiveRecord::Base.connection.select_all('SELECT * FROM `notes` INNER JOIN `action_text_rich_texts` ON action_text_rich_texts.record_id = notes.id AND action_text_rich_texts.record_type = "Note"')

    # note_ids = []
    # notes.each do |note|
    #   if ApplicationController.helpers.strip_tags(note['body']).match(content)
    #     note_ids << note['id']
    #   end
    # end

    #その中からタイトルか本文(ActionText)の内容(ここでHTMLタグを除く)で合致するものを取得
    note_ids = notes.map {|note| note['id'] if note['title'].match(content)}
    note_ids += notes.map {|note| note['id'] if ApplicationController.helpers.strip_tags(note['body']).gsub(/[\r\n]/,"").match(content)}

    Note.where(id: note_ids)

    # .where("title LIKE ? OR action_text_rich_texts.body LIKE ?", "%#{content}%", "%#{content}%")
  end

  #Action Textの使用
  has_rich_text :contents

  validates :title, presence: true
  validates :contents, presence: true

end
