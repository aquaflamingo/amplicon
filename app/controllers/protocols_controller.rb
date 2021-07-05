class ProtocolsController < ApplicationController
  before_action :set_proto, only: [:show, :edit, :favorite, :update]
  before_action :require_login

  def index
    @protos = current_user.protocols
  end

  def show
  end

  def new
    @proto = current_user.protocols.new
  end

  def edit
  end

  #######################################################
  # Write
  #######################################################
  def update
    if @proto.update(proto_params)
      redirect_to @proto, notice: "Updated!"
    else
      flash.now[:warning] = @proto.errors.full_messages.join(', ')

      render 'edit'
    end
  end
  
  def favorite 
    if favorite_params[:action_type] == "favorite"
      current_user.favorites << @proto
    else 
      current_user.favorites.delete(@proto.id)
    end

    current_user.save!
    redirect_to @proto
  end

  def create
    @proto = current_user.protocols.build(proto_params)
    if @proto.save
      redirect_to @proto, success: "Protocol created"
    else
      flash.now[:warning] = "Failed to create protocol: #{@proto.errors.full_messages.join(". ")}"

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
