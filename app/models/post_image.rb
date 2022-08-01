class PostImage < ApplicationRecord
  has_one_attached :image
  # has_many_attachedとすると、一つの投稿に対し、複数の写真が関連づけられる。

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

# dependent: :destroyは = has_manyで使えるオプション。 1:Nの関係において、「1」のデータが削除された場合、関連する「N」のデータも削除される設定
# 投稿を削除したら、それに紐づくいいね、コメントも一緒に削除させるもの


# バリデーション設定
validates :shop_name, presence: true
validates :image, presence: true


# 画像の設定
# 画像が設定されない場合はapp/assets/imagesに格納されている
# no_image.jpgという画像をデフォルト画像としてActiveStorageに格納し、格納した画像を表示する

 def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
 end

# いいねの設定
# favorited_by? = 引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
