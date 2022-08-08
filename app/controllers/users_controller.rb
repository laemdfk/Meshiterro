class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
   @post_images = @user.post_images.page(params[:page]).per(5)
  end

  def edit
    if User.guest == current_user
      redirect_to post_images_path, flash: {alert: "ゲストユーザーは編集できません"}
      return
    end

    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
