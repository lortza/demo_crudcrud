class PostsController < ApplicationController
  skip_before_action :require_login, :only => [:index, :show]

  def index
    query = query_params[:query]
    if query
      @posts = Post.search(title: query[:title], body: query[:body]).includes(:tags, :author)
    else
      @posts = Post.all
    end
  end

  def new
    # use posts.build instead of Post.new so that the
    # new post is associated with the current user by default
    @post = current_user.posts.build
  end

  def create
    @post = Post.new(whitelisted_post_params)
    if @post.save
      # Woohoo
      redirect_to @post
    else
      # boohoo
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(whitelisted_post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).destroy!
    redirect_to posts_path
  end



  private

  def whitelisted_post_params
    if params[:post].is_a?(ActionController::Parameters)
      params.require(:post).permit(:title, :body,  :author_id, :tag_ids => [])
    else
      {:title => params[:title], :body => params[:body]}
    end
  end

  def query_params
    params.permit(:query => [:title, :body])
  end

end
