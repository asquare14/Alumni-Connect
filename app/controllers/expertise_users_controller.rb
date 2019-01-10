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

    def available_mentors
        arr = Array.new
        @user_all = User.where(mentor: true)
        @user_all.each do |user|
            if user == current_user
                next
            end 
            i = 0
            user.expertises.each do |expertise|
                if current_user.expertises.include?(expertise)
                    i = i + 1
                end
            end
            arr << i.to_s + " " + user.id.to_s
        end
        arr = arr.sort_by{ |s| s.scan(/\d+/).first.to_i }.reverse! 
       
        user_ids = Array.new
        i = 0 
        arr.each do |s|
            break if i == 5
            user_ids <<  s.scan(/\d+/).second.to_i
            i = i + 1          
        end
        
        @user = user_ids.collect {|i| User.find(i) } 
        return @user
    end


    def show_mentors
        @user = available_mentors
    end

end
