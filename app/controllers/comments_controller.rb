class CommentsController < ApplicationController
    before_action :get_post
    before_action :authenticate_user!
    
    def new
      @comment = Comment.new
    end
    
    def create
        @comment = @post.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_url(@post), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render 'posts/show', status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

    end

    private
    def comment_params
        params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end

    def get_post
        @post = Post.find(params[:post_id])
    end
end
