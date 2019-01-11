class ExpertiseUsersController < ApplicationController
    def new
        if ExpertiseUser.exists?(user_id: current_user.id)
            if current_user.mentee
                return redirect_to action: 'show_selected_mentor'
            else
                return redirect_to action: 'show_mentees'
            end
        end
        @expertise_users = ExpertiseUser.new()
        @user = User.where(id: current_user.id)
    end

    def create
        ExpertiseUsersManager.new(params[:user][:expertise_ids], current_user).run
        if current_user.mentee
            redirect_to(:action => 'show_mentors')
        else
            redirect_to action: 'show_mentees'
        end
    end

    def available_mentors
        arr = Array.new
        @user_all = User.where("mentor = true AND no_of_mentors < ?", 5)
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
        if current_user.mentor
            return redirect_to root_path
        end
        @user = available_mentors
    end

    def select_mentor
        if current_user.mentor
            return redirect_to root_path
        end
        @mentor_mentee = MentorMentee.new()
        @mentor_mentee.mentee_id = current_user.id
        @mentor_mentee.mentor_id = params[:user_id]
        @mentor_mentee.save
        @mentor = User.where(id: params[:user_id]).first
        @mentor.no_of_mentors = @mentor.no_of_mentors + 1
        @mentor.save
        redirect_to action: 'show_selected_mentor'
    end

    def show_selected_mentor
        if current_user.mentor
            return redirect_to root_path
        end
        @mentor = User.where(id: current_user.as_mentees.first.mentor_id).first
    end

    def show_mentees
        if current_user.mentee
            return redirect_to root_path
        end
        arr = Array.new
        @users = current_user.as_mentors
        @users.each do |user|
            arr << user.mentee_id
        end
        @mentees = User.where(id: arr)
    end
end
