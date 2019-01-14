class RegistrationsController < Devise::RegistrationsController

    def create
        super do
            if resource.company.blank?
                resource.mentee = 1
                resource.mentor = 0
            else
                resource.mentor = 1
                resource.mentee = 0
            end
            resource.save
        end
    end    

    def mentor
      @user = User.where(id: current_user.id)
    end


    def mentee
      @user = User.where(id: current_user.id)
    end

    private
  
    def sign_up_params
      params.require(:user).permit( :name, 
                                    :email,
                                    :institute,
                                    :graduation,
                                    :branch,
                                    :linkedin,
                                    :company, 
                                    :password, 
                                    :password_confirmation,
                                    :dp,
                                    expertise_ids:[])
    end
  
    def account_update_params
      params.require(:user).permit( :name, 
                                    :email,
                                    :company, 
                                    :password, 
                                    :password_confirmation, 
                                    :current_password)
    end
   
    def user_params
      params.require(:user).permit( :name, 
                                    :email,
                                    :institute,
                                    :graduation,
                                    :branch,
                                    :linkedin,
                                    :company, 
                                    :password, 
                                    :password_confirmation,
                                    :dp,
                                    expertise_ids:[])    
    end
end
  
