class ChannelsController < ApplicationController

  def create
    @channel = Channel.new(channel_params)
    @business = Business.find_by(id: business_id)

    respond_to do |format|
      if @channel.save
        format.html { redirect_to business_path(@business), notice: "channel was successfully created" }
      else
        format.html { redirect_to business_path(@business), status: :unprocessable_entity }
      end
    end
  end

  private 

  def channel_params
    params.require(:channel).permit(:user_id, :business_id, :name)
  end
end
