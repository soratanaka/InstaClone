class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :autheniticate_user, {only: [:edit, :update]}
  before_action :forbid_login_user, {only: [:name, :create, :login_form, :login]}
  before_action :ensure_current_user, {only: [:edit, :update]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,:avatar,:avater_cashe,:plofile,
                                :password_confirmation)
  end

  def ensure_current_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to("/posts/index")
    end
  end
end