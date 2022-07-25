class PostImage < ApplicationRecord
  has_one_attached :image
  # has_many_attachedとすると、一つの投稿に対し、複数の写真が関連づけられる。
  
  belongs_to :user
end
