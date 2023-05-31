# frozen_string_literal: true

# doc
class ArticlesController < ApplicationController
  # http_basic_authenticate_with name: "bassem", password: "root", except: [:index, :show]

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, except: %i[index new create]
  # if the user is signed in display all the articles else display only the published ones
  def index
    @articles = user_signed_in? ? Article.sorted : Article.published.sorted
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status, :published_at)
  end

  def set_article
    @article = user_signed_in? ? Article.find(params[:id]) : Article.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
