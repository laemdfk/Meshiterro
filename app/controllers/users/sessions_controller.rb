# ゲストユーザー用コード
class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to post_images_path, notice: 'guestuserでログインしました。'
  end
end