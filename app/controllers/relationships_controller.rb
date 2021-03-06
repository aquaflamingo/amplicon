# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :require_login
  before_action :set_relationship, only: [:destroy]

  def create
    @user = User.find(relationship_params[:followed_id])

    current_user.follow(@user)
    current_user.save

    redirect_to @user
  end

  def destroy
    @user = @relationship.followed

    current_user.unfollow(@user)
    current_user.save

    redirect_to @user
  end

  private

  def set_relationship
    @relationship = Relationship.find(params[:id])
  end

  def relationship_params
    params.permit(:followed_id)
  end
end
