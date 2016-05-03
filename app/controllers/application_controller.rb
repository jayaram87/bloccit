class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
  
    def require_sign_in
      
      unless current_user
        flash[:alert] = "You must be logged in to do that"
        redirect_to new_session_path
      end
      
    end
    
    def topic_comment(comment)
        @topic = Topic.find(params[:topic_id])
        comment = @topic.comments.new(comment_params)
        comment.user = current_user
        
        if comment.save
            flash[:notice] = "Topic Comment was saved"
            redirect_to @topic
        else
            flash[:alert] = "Comment was not saved"
            redirect_to @topic
        end
    end
    
    def post_comment(comment)
        @post = Post.find(params[:post_id])
        comment = @post.comments.new(comment_params)
        comment.user = current_user
        
        if comment.save
            flash[:notice] = "Post Comment was saved"
            redirect_to @post
        else
            flash[:alert] = "Comment was not saved"
            redirect_to @post
        end
    end
    
    def delete_topic_comment(comment)
        @topic = Topic.find(params[:topic_id])
        comment = @topic.comments.find(params[:id])
        
        if comment.destroy
            flash[:notice] = "Topic comment was deleted"
            redirect_to @topic
        else
            flash[:alert] = "Comment was deleted"
            redirect_to @topic
        end
    end
    
    def delete_post_comment(comment)
        @post = Post.find(params[:post_id])
        comment = @post.comments.find(params[:id])
        
        if comment.destroy
            flash[:notice] = "Post comment was deleted"
            redirect_to @post
        else
            flash[:alert] = "Comment was deleted"
            redirect_to @post
        end
    end   
    
    def comment_params
        params.require(:comment).permit(:body)
    end
    
end
