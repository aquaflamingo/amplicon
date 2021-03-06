# frozen_string_literal: true

class UsersController < Clearance::UsersController
  before_action :require_login, only: %i[show edit update followers following favorites]
  before_action :set_user, only: %i[show followers following favorites]
  before_action :set_user_protocols, only: [:show]

  #########################################################
  # Read
  #########################################################
  def show; end

  def edit
    @user = current_user
  end

  def followers
    @title = "Followers"
    # TODO paginate
    @users = @user.followers

    render 'show_follow'
  end

  def following
    @title = "Following"
    # TODO paginate
    @users = @user.following

    render 'show_follow'
  end

  def favorites
  end

  #########################################################
  # Write
  #########################################################
  def update
    @user = current_user

    if @user.update(user_update_params)
      redirect_to @user
    else
      flash.now[:warning] = @user.errors.full_messages.join(' ')

      render :edit
    end
  end

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      redirect_to sign_up_path, warning: @user.errors.full_messages.join(' ')
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_protocols
    @user_protocols ||= find_user_protocols
  end

  def user_update_params
    user_params.permit(:username, :avatar, :description, :display_name)
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
    private_status = [false]

    # If the current user is the user being shown show the private repositories
    # Otherwise, leave out
    private_status << true if current_user.id == @user.id

    @user.protocols.where(private: private_status)
  end
end
