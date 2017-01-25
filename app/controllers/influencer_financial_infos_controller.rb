class InfluencerFinancialInfosController < ApplicationController
  AC_TYPES = {"SAVING"=>1,"CURRENT"=>2}

    def create
     if current_influencer.influencer_financial_info.present?
      current_influencer.influencer_financial_info.update(influencer_financial_infos_params)
      flash[:success] =  "Successfully Updated"
    else
      InfluencerFinancialInfo.create!(influencer_financial_infos_params)
      flash[:success] =  "Successfully Created"
    end

    redirect_to :back
  end

private

  def influencer_financial_infos_params
    params.require(:influencer_financial_info).permit!
  end

end
