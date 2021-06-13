class UsersController < Clearance::UsersController
  before_action :require_login, only: [:show]
  before_action :set_user, only: [:show]
  before_action :set_user_protocols, only: [:show]

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      redirect_to sign_up_path, warning: @user.errors.full_messages.join(" ")
    end
  end

  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_user_protocols
    @user_protocols ||= find_user_protocols
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

  def find_user_protocols
    private_status = [:false]

    # If the current user is the user being shown show the private repositories
    # Otherwise, leave out
    if current_user.id == @user.id
      private_status << :true 
    end

    @user.protocols.where(private: private_status)
  end
end
