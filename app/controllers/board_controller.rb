class BoardController < ApplicationController

#   include TwilioHelper

#   def create
#     @post = Post.find(params[:article_id])
#     @comment = @article.comments.create(comment_params)

#     redirect_to article_path(@article)
#   end

#   def destroy
#     @article = Post.find(params[:article_id])
#     @comment = @article.comments.find(params[:id])
#     @comment.destroy
#     redirect_to article_path(@article)
#   end
 
#   private

#     def comment_params
#       params.require(:comment).permit(:commenter, :body)
#     end
end