class Public::FreePostsController < ApplicationController
  before_action :authenticate_member!
  before_action :is_matching_login_member, except: [:index, :create, :show]

  def index
    @free_post = FreePost.new
    @free_posts =FreePost.all
    
  end

  def show
    @free_post = FreePost.find(params[:id])
    @member = @free_post.member
    @free_post_new = FreePost.new
    @comment = Comment.new
    
  end



  def create
    @free_post =FreePost.new(free_posts_params)
    @free_post.member_id = current_member.id
    if @free_post.save
      redirect_to free_posts_path, notice: "successfully"
    else
      @free_posts =FreePost.all
      render 'index'
    end
  end


  def edit
    @free_post = FreePost.find(params[:id])
  end

  

  def update
    @free_post = FreePost.find(params[:id])
    if @free_post.update(free_posts_params)
      redirect_to free_posts_path(@free_post), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @free_post = FreePost.find(params[:id])
    @free_post.destroy
    redirect_to free_posts_path
  end

  private
  def free_posts_params
    params.require(:free_post).permit(:body, :image)
  end


  def is_matching_login_member
    free_post = FreePost.find(params[:id])
    unless free_post.member.id == current_member.id
      redirect_to free_posts_path
    end
  end
end
