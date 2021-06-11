class UsersController < Clearance::UsersController
  before_action :require_login, only: [:show]
  before_action :set_user, only: [:show]

  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
