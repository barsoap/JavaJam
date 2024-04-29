class Follow < ApplicationRecord
  belongs_to :user

  scope :is_active, -> { joins(:user).where(user: {is_active: true}) }
end
