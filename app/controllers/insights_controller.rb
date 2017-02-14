class InsightsController < ApplicationController

# page consumptions
# page consumptions by consumption type
# page fans
# page fans locate
# page fans gender age
# page views total

  def add_page_consumptions
    if PageInsight.find_by_facebook_page_id(params[:page_id]).present?
        PageInsight.find_by_facebook_page_id(params[:page_id]).update_attributes(:page_consumptions=>params[:page_consumptions])
    else
      PageInsight.create!(:facebook_page_id=>params[:page_id],:page_consumption=>params[:page_consumption])
    end
    puts params.to_yaml
    render :json=>{
      message:"Updated",
    status:200}
  end

  def add_page_consumptions_by_consumption_type
    if PageInsight.find_by_facebook_page_id(params[:page_id]).present?
        PageInsight.find_by_facebook_page_id(params[:page_id]).update_attributes(:page_consumptions=>params[:page_consumptions_by_consumption_type])
    else
      PageInsight.create!(:facebook_page_id=>params[:page_id],:page_consumptions=>params[:page_consumptions_by_consumption_type])
    end
    puts params.to_yaml
    render :json=>{
    status:200}
  end

  def add_page_fans
    if PageInsight.find_by_facebook_page_id(params[:page_id]).present?
        PageInsight.find_by_facebook_page_id(params[:page_id]).update_attributes(:page_fans=>params[:page_fans])
    else
      PageInsight.create!(:facebook_page_id=>params[:page_id],:page_fans=>params[:page_fans])
    end
    puts params.to_yaml
    render :json=>{
    status:200}
  end

  def add_page_fans_locale
 
    if PageInsight.find_by_facebook_page_id(params[:page_id]).present?
        highest_page_locale_name = params["page_fans_locale"].sort_by{|_key,value| value}.reverse.to_h.first[0]
        highest_page_locale_value = params["page_fans_locale"].sort_by{|_key,value| value}.reverse.to_h.first[1]
        PageInsight.find_by_facebook_page_id(params[:page_id]).update_attributes(:highest_page_locale_name=>highest_page_locale_name,:highest_page_locale_value=>highest_page_locale_value)
    else
      highest_page_locale_name = params["page_fans_locale"].sort_by{|_key,value| value}.reverse.to_h.first[0]
      highest_page_locale_value = params["page_fans_locale"].sort_by{|_key,value| value}.reverse.to_h.first[1]
      PageInsight.find_by_facebook_page_id(params[:page_id]).update_attributes(:highest_page_locale_name=>highest_page_locale_name,:highest_page_locale_value=>highest_page_locale_value)
    end
    puts params.to_yaml
    render :json=>{
    status:200}
  end

  def add_page_fans_gender_age
    if PageInsight.find_by_facebook_page_id(params[:page_id]).present?
        PageInsight.find_by_facebook_page_id(params[:page_id]).update_attributes(:page_fans_gender_age=>params[:page_fans_gender_age])
    else
      PageInsight.create!(:facebook_page_id=>params[:page_id],:page_fans_gender_age=>params[:page_fans_gender_age])
    end
    puts params.to_yaml
    render :json=>{
    status:200}
  end

  def add_page_views_total
    if PageInsight.find_by_facebook_page_id(params[:page_id]).present?
        PageInsight.find_by_facebook_page_id(params[:page_id]).update_attributes(:page_views_total=>params[:page_views_total])
    else
      PageInsight.create!(:facebook_page_id=>params[:page_id],:page_views_total=>params[:page_views_total])
    end
    puts params.to_yaml
    render :json=>{
    status:200}
  end

end
