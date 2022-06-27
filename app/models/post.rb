class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  def inc_likes
    self.likes ? self.likes += 1 : self.likes = 1
    self.likes
  end
end
