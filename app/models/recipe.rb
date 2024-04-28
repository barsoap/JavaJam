class Recipe < ApplicationRecord

  has_one_attached :recipe_image

  belongs_to :user
  has_many :recipe_processes, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  has_many :recipe_bookmarks, dependent: :destroy

  #recipe_processes(cocoon)
  accepts_nested_attributes_for :recipe_processes, reject_if: :all_blank, allow_destroy: true

  def bookmark_exist?(current_user, recipe)
    RecipeBookmark.find_by(user_id: current_user.id, recipe_id: recipe.id).nil?
  end

  #検索メソッド
  def self.search_for(content)
    Recipe.where('title LIKE ?', '%' + content + '%')
  end

  #タグ
  def save_tags(tags)
    tag_list = tags.split(/[[:blank:]]+/) #タグをスペース区切りで分割し配列にする
    current_tags = self.tags.pluck(:name) #自分自身に関連づいたタグを取得する
    old_tags = current_tags - tag_list #元々自分に紐付いていたタグと投稿されたタグの差分を抽出、記事更新時に削除されたタグ？
    new_tags = tag_list - current_tags #新規に追加されたタグ
    old_tags.each do |old| #tagsテーブルから該当のタグを探し出して削除する
      self.tags.delete Tag.find_by(name: old)
    end
    new_tags.each do |new| #tagsテーブルから新規に追加されたタグを探して、tag_mapsテーブルにtag_idを追加する
      new_recipe_tag = Tag.find_or_create_by(name: new)
      self.tags << new_recipe_tag
    end
  end

  validates :title, presence: true
  validates :contents, presence: true
  validates :evaluation, presence: true


end
