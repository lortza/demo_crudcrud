class CommentsController < ApplicationController

  def index
    @comments = Comment.limit(10)
    # @comments = extract_commentable.comments
  end

  def update_comments
    if Comment.update(update_comments_params.keys, update_comments_params.values)
      flash[:success] = "Comments updated!"
      redirect_to comments_path
    else
      flash.now[:failure] = "Boo error for comment update..."
      render :index
    end
  end

  private
  def update_comments_params
    params.require(:comments) #  => { :body })
  end

  def extract_commentable
    # the `request` object contains all the HTTP parameters
    # we were sent.  Among the many things you can dig into
    # it to find, you can also locate the path that we were
    # originally sent on, as we're doing here.
    # We also use multiple assignment to grab the second
    # e.g. "posts" and third e.g. "1" elements of that path
    # for use in the next part to help find the actual object
    # which we're trying to find the comments for
    resource, id = request.path.split('/')[1,2]

    # the `singularize` method turns plurals singular
    # the `classify` method turns snake_case into CamelCase
    # the `constantize` method locates a class by that name
    resource.singularize.classify.constantize.find(id)
  end

end
