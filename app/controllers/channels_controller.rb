class ChannelsController < ApplicationController
  before_action :set_product, only: [:update]

  def create
    @channel = Channel.new(channel_params)
    @business = Business.find_by(id: params[:channel][:business_id])

    respond_to do |format|
      if @channel.save
        format.html { redirect_to business_path(@business), notice: "channel was successfully created" }
      else
        format.html { redirect_to business_path(@business), status: :unprocessable_entity }
      end
    end
  end

  def update
    @business = @channel.business

    respond_to do |format|
      if @channel.update(channel_params)
        format.hrml { redirect_to business_path(@business), notice: "Channel was successfully updated" }
      else
        format.html { redirect_to business_path(@business), status: :unprocessable_entity , alert: "Error, channel could not be updated: #{channel.errors.full_messages.join(",")}" }
      end
    end
  end

  private

  def set_channel
    @channel = Channel.find_by(id: params[:id])
  end

  def channel_params
    params.require(:channel).permit(:user_id, :business_id, :name)
  end
end
