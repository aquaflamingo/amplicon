class UsersController < Clearance::UsersController
  before_action :require_login, only: [:show]
  before_action :set_user, only: [:show]

  def new
    @user = user_from_params
    render template: "users/new"
  end

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new", warning: @user.errors.full_messages.join(" ")
    end

  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  # Parameters used to create a new user record via +new+ and +create
  def user_from_params
    email = user_params.delete(:email)
    username = user_params.delete(:username)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.username = username
      user.email = email
      user.password = password
    end
  end
end
