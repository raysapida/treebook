class Blog::ArticlesController < ApplicationController
  def index
    @articles = Blog::Article.all
  end

  def show
    @article = Blog::Article.find_by_name(params[:id])
  end
end
