class ExpertiseUsersController < ApplicationController
    def new
        @expertise_users = ExpertiseUser.new()
        @user = User.where(id: current_user.id)
    end

    def create
        ExpertiseUsersManager.new(params[:user][:expertise_ids], current_user).run
        redirect_to root_path
    end
end
