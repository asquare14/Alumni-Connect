class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :mailbox, :conversation

  def redirect_if_not_signed_in
    redirect_to root_path if !user_signed_in?
  end
  
  def redirect_if_signed_in
    redirect_to root_path if user_signed_in?
  end


  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end
  
end
