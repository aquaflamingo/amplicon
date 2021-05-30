class RepositoriesController < ApplicationController
  before_action :set_repo, only: [:show]
  def index
    @repositories = Repository.all
  end

  def show
  end

  def create
    @repo = Repository.new(repo_params)
    if @repo.save
      redirect_to @repo, success: "Repository created"
    else
      redirect_to new_repository_path, warning: "Failed to create repository"
    end
  end

  def new
    @repo = Repository.new
  end

  private 
  def set_repo
    @repo = Repository.find(params[:id])
  end

  def repo_params
    params.require(:repository).permit(:name, :description, :resource)
  end
end
