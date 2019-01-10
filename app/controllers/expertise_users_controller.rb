class ExpertiseUsersController < ApplicationController
    def new
        @expertise_users = ExpertiseUser.new()
        @user = User.where(id: current_user.id)
    end

    def create
        ExpertiseUsersManager.new(params[:user][:expertise_ids], current_user).run
        if current_user.mentee
            redirect_to root_path
        else
            redirect_to hobby_posts_path
        end
    end
end
