class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @user = User.find(current_user.id)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver 
      redirect_to user_path(@user.id), notice: "お問合せを送信しました"
    else
      render :new, notice: "お問合せに失敗しました"
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end
  
    def contact_params
      params.require(:contact).permit(:name, :email, :content)
    end
end
