class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  # # is_deletedがfalseならtrueを返すようにしている
  # def active_for_authentication?
  #   super && (is_deleted == false)
  # end


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
end
