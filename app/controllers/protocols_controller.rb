class ProtocolsController < ApplicationController
  before_action :set_proto, only: [:show]
  before_action :require_login

  def index
    @proto = current_user.protocols
  end

  def show
  end

  def create
    @proto = current_user.protocols.build(proto_params)
    if @proto.save
      redirect_to @proto, success: "Protocol created"
    else
      redirect_to new_protocol_path, warning: "Failed to create protocol"
    end
  end

  def new
    @proto = current_user.protocols.new
  end

  private 
  def set_proto
    @proto = Protocol.find(params[:id])
  end

  def proto_params
    params.require(:protocol).permit(:name, :description, :equipment, :reagents, :materials)
  end
end
