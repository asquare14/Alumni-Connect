class GroupsController < ApplicationController
    before_action :authenticate_user!

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
