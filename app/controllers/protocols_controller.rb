# frozen_string_literal: true

class ProtocolsController < ApplicationController
  before_action :set_proto, only: %i[show edit favorite update destroy]
  before_action :require_login

  def index
    @protos = Protocol.all_public
  end

  def show; end

  def new
    @proto = current_user.protocols.new
  end

  def edit; end

  #######################################################
  # Write
  #######################################################
  def destroy
    # Only owner can destroy the protocol
    if current_user.owns?(@proto)
      @proto.destroy
      redirect_to :root, success: "Protocol was deleted"
    else
      redirect_to protocol_path(@proto), warning: "Cannot delete protocol you do not own"
    end
  end

  def update
    if @proto.update(proto_params)
      redirect_to @proto, notice: 'Updated!'
    else
      flash.now[:warning] = @proto.errors.full_messages.join(', ')

      render 'edit'
    end
  end

  def favorite
    if favorite_params[:action_type] == 'favorite'
      current_user.favorite(@proto)
    else
      current_user.unfavorite(@proto.id)
    end

    current_user.save!
    redirect_to @proto
  end

  def create
    @proto = current_user.protocols.build(proto_params)
    if @proto.save
      redirect_to @proto, success: 'Protocol created'
    else
      flash.now[:warning] = "Failed to create protocol: #{@proto.errors.full_messages.join('. ')}"

      render 'new'
    end
  end

  private

  def set_proto
    @proto = Protocol.find(params[:id])
  end

  def proto_params
    params.require(:protocol).permit(:name, :description, :content, :private)
  end

  def favorite_params
    params.permit(:action_type)
  end
end
