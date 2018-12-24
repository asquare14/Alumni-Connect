class CommentsController < ApplicationController
    def create
        params.permit!
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(params[:comment])
        redirect_to post_path(@post)
    end
end
