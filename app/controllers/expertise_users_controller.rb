class ExpertiseUsersController < ApplicationController
    def new
        if ExpertiseUser.exists?(user_id: current_user.id)
            redirect_to root_path
        end
        @expertise_users = ExpertiseUser.new()
        @user = User.where(id: current_user.id)
    end

    def create
        ExpertiseUsersManager.new(params[:user][:expertise_ids], current_user).run
        if current_user.mentee
            redirect_to(:action => 'show_mentors')
        else
            redirect_to hobby_posts_path
        end
    end

    def show_mentors
    end

end
