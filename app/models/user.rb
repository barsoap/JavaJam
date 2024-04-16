class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :equipments, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def active_for_authentication?
    super && is_active?
  end

  def inactive_message
    is_active? ? super : :not_active
  end

  def self.search_for(content,method) #検索メソッド
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE?', content + '%')
    elsif method == 'backword'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  validates :name, presence: true
  validates :profile, length: { maximum: 120}
end
