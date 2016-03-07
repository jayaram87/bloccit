class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each do |post|
      index = 0
      if index%5 == 0
        post.title = "SPAM"
      end
      index += 1
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
