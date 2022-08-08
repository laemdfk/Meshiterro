class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   # アソシエーション設定。1:N の「1」側にあたるモデルに、has_many を記載する必要がある
   has_many :post_images, dependent: :destroy
   has_many :post_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy

  #profile_image設定
  has_one_attached :profile_image

def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
end


# ゲストユーザー設定
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|    # find_or_create_by = データの検索と作成を自動的に判断して処理を行う,Railsのメソッドの一つ
      user.password = SecureRandom.urlsafe_base64   # SecureRandom.urlsafe_base64 = ランダムな文字列を生成するRubyのメソッド
      user.name = "guestuser"
    end
  end

end
