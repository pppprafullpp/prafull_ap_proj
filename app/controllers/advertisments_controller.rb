class AdvertismentsController < ApplicationController

  def create
    Advertisement.create!(advertisement_params)
    # raise params.to_yaml
    flash[:success] = "Created successfully"
    redirect_to :back
  end

private

  def advertisement_params
    params.require(:advertisement).permit!
  end

end
