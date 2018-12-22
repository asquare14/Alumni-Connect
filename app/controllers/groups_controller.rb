class GroupsController < ApplicationController
    before_action :authenticate_user!
    #find institute name of user
    #find group==institute name
    #add to group
    #display groups
    
    def index
        user_institute = current_user.institute
        @group = Group.where(name: user_institute).take
        if @group.users.include?(current_user)
            puts()
        else
            current_user.groups << @group
        end
        
    end

   

end
