class ProtocolsController < ApplicationController
  before_action :set_protocol, only: [:show]
  def index
    @proto = Protocol.all
  end

  def show
  end

  def create
    @proto = Protocol.new(proto_params)
    if @proto.save
      redirect_to @proto, success: "Protocol created"
    else
      redirect_to new_protocol_path, warning: "Failed to create protocol"
    end
  end

  def new
    @proto = Protocol.new
  end

  private 
  def set_proto
    @proto = Protocol.find(params[:id])
  end

  def proto_params
    params.require(:protocol).permit(:name, :description)
  end
end
