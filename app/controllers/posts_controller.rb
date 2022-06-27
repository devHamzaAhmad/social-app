class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  # GET /posts/1 or /posts/1.json
  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    # @post = Post.new
    @user = User.find(params[:user_id])
  end

  # GET /posts/1/edit
  def edit
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  # POST /posts or /posts.json
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    # @post.likes = 0
    # @user = User.find(params[:user_id])
    if @post.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    # post.likes = params[:likes]
    if @post.update({:likes => params[:likes]})
      redirect_to user_post_path(@user, @post)
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:likes, :user_id, :image)
    end
end
