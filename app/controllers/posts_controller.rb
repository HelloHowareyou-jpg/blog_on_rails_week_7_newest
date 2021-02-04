class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only:[:show, :edit, :update, :destroy]
  before_action :authorize_user!,only:[:edit,:update,:destroy]
  
  def index
      @posts=Post.all.order(created_at: :desc)
  end

  def show
      @comments=@post.comments.order(created_at: :desc)
      @comment=Comment.new
  end

  def destroy
      @post.destroy
      redirect_to posts_path
  end

  def new
      @post=Post.new
  end

  def create
      @post=Post.new post_params
      @post.user = current_user

      if @post.save
          flash[:notice]="Post created successfully."
          redirect_to post_path(@post)
      else
          render :new
      end
  end
  
  def edit
    id = params[:id]
    @post = Post.find(id)
  end

  def update
    id = params[:id]
    @post = Post.find(id)
    if @post.update(params.require(:post).permit(:title, :body))
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private
  def find_post
      @post=Post.find params[:id] 
  end
  def post_params
      params.require(:post).permit(:title, :body)
  end
  def authorize_user!
      redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @post)
  end


end