class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :equipments, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :follows
  has_many :recipe_bookmarks, dependent: :destroy

  # フォローユーザーの検索
  #   フォロー済みの場合、ユーザーデータを返す
  #   フォローしていない場合は、nilを返す
  def following?(current_user, follow_id)
    # Followから自分と対象のユーザーがANDになっているレコードを検索
    Follow.find_by(user_id: follow_id, follow_id: current_user.id)
  end

  # フォローしている一覧取得
  def followed(user)
    Follow.where(follow_id: user.id)
  end

  # フォローされている一覧取得
  def follower(current_user)
    Follow.where(user_id: current_user.id)
  end

  has_one_attached :profile_image

  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

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

  #検索メソッド
  def self.search_for(content)
    User.where('name LIKE ? AND is_active == true', "%#{content}%")
  end

  validates :name, presence: true
  validates :profile, length: { maximum: 120}
end
