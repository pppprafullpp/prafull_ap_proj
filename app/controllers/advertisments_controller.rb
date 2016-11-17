class AdvertismentsController < ApplicationController

  def create
raise params.to_yaml
    Advertisement.create!(advertisement_params)

    flash[:success] = "Created successfully"
    redirect_to :back
  end

private

  def advertisement_params
    params.require(:advertisement).permit!
  end

end
