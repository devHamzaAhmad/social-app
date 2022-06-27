class User < ApplicationRecord
  has_one_attached :avatar
  has_many :users
  has_many :posts
  validates :avatar, presence: true

end
