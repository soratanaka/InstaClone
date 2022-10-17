class ProfilesController < ApplicationController
    before_action :set_user,only: %i[edit update]
    before_action :forbid_login_user, {only: [:top]}
    
  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "ユーザーを更新しました"}
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email,:avatar,:avatar_cache,:plofile)
  end
end