class ExpertiseUsersController < ApplicationController
    require "google/cloud/language"

    def new
        if ExpertiseUser.exists?(user_id: current_user.id)
            if current_user.mentee
                return redirect_to new_message_path
            else
                return redirect_to action: 'show_mentees'
            end
        end
        @expertise_users = ExpertiseUser.new()
        @user = User.where(id: current_user.id)
    end
    
    def send_description(text_content)
        # text_content = "Text to classify"

        cat_arr = []

        puts("---------------------------------------------------------")
        language = Google::Cloud::Language.new
        response = language.classify_text content: text_content, type: :PLAIN_TEXT
        
        categories = response.categories
        
        categories.each do |category|
            cat_arr << category.name
            # puts "Name: #{category.name} Confidence: #{category.confidence}"
        end
        return cat_arr
    end
    def create
        #ExpertiseUsersManager.new(params[:user][:expertise_ids], current_user).run
        cat_arr = send_description(params[:message])

        puts(cat_arr)
	ids = []	

	cat_arr.each do |cat|
		if Expertise.exists?(name: cat)
		    @temp = Expertise.where(name: cat).first
		    ids << @temp.id
		    next
		end
		@expertise = Expertise.new()
		@expertise.name = cat
		@expertise.flag = 1
		@expertise.save
		puts @expertise.id
		ids << @expertise.id
		puts cat
	end

	ids = ids + params[:user][:expertise_ids]
	ExpertiseUsersManager.new(ids, current_user).run

        #Expertise.where(:name=>s_arr).first_or_create

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
            if !ExpertiseUser.exists?(user_id: user.id)
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
        
        if !current_user.as_mentees.blank?
            return redirect_to new_message_path
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
        redirect_to new_message_path
    end

    def show_selected_mentor
        if current_user.mentor
            return redirect_to root_path
        end
     
        if current_user.as_mentees.blank?
            return redirect_to(:action => 'show_mentors')
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
