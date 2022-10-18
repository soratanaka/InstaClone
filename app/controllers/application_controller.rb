class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  def autheniticate_user
    if @current_user==nil
      flash[:notice]="ログインが必要です"
      redirect_to("/login")
    end
  end

  def set_current_user
    @current_user=User.find_by(id :session[:user_id])
  end
      
  def fobid_login_user
    if @current_user
      flash[:notice]="ログインしています"
      redirect_to("/posts/index")
    end
  end

  private

  def login_required
    redirect_to new_session_path unless current_user
  end
  
end