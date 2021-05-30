class RepositoriesController < ApplicationController
  before_action :set_repo, only: [:show]
  def index
    @repositories = Repository.all
  end

  def show
  end

  def create
  end

  def new
  end

  private 
  def set_repo
    @repo = Repository.find(params[:id])
  end
end
