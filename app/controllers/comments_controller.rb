class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, except: [:index, :create]

  def index
    @comments = @article.comments
  end

  def show; end

  def create
    @comment = @article.comments.create(comment_params)
  
    if @comment.save
      redirect_to @article, notice: "comment created successfully."
    else
      flash.alert = "Error in creating a comment"
      render "articles/show", status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to article_path(@article), notice: "Comment has been updated!"
    else
      flash.alert = "Error in editing the comment"
      render :edit, status: :unprocessable_entity
    end
    
  end

  def destroy
    @comment.destroy
    redirect_to @article, notice: 'comment has been deleted'
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
