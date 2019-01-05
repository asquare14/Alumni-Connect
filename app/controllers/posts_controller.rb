class PostsController < ApplicationController
    before_action :redirect_if_not_signed_in, only: [:new]
    
    def show
        @post = Post.find(params[:id])
    end
    
    def hobby
        posts_for_branch(params[:action])
    end
    
    def study
        posts_for_branch(params[:action])
    end
    
    def team
        posts_for_branch(params[:action])
    end
    
    def new
        @branch = params[:branch]
        @categories = Category.where(branch: @branch)
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        if @post.save
          redirect_to post_path(@post) 
        else
          redirect_to root_path
        end
    end


    def upvote
        @post = Post.find(params[:id])
        @post.upvote_by current_user
        category = Category.find_by(id: @post.category_id)
        branch_of = category.branch
        if branch_of == 'study'
            redirect_to study_posts_path
        end
        if branch_of == 'hobby'
            redirect_to hobby_posts_path
        end
    end
    
    def downvote
        @post = Post.find(params[:id])
        @post.unliked_by current_user
        redirect_to post_path(@post) 
    end

    private
    
    def posts_for_branch(branch)
        @categories = Category.where(branch: branch)
        @posts = get_posts.paginate(page: params[:page])
        @posts = @posts.where(user_id: User.where(institute: current_user.institute).pluck(:id))
        respond_to do |format|
            format.html
            format.js { render partial: 'posts/posts_pagination_page' }
        end
    end
    
    def post_params
        params.require(:post).permit(:content, :title, :category_id, :deadline, :rel_link,:image,:venue).merge(user_id: current_user.id)
    end
    
    def get_posts
        branch = params[:action]
        search = params[:search]
        category = params[:category]
        if category.blank? && search.blank?
        posts = Post.by_branch(branch).all
        elsif category.blank? && search.present?
        posts = Post.by_branch(branch).search(search)
        elsif category.present? && search.blank?
        posts = Post.by_category(branch, category)
        else
        end
    end
end
