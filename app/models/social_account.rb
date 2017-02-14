class SocialAccount < ActiveRecord::Base
  validates_uniqueness_of :facebook_page_id
  # has_one :page_insight, :foreign_key => :facebook_page_id
  def self.search(params)
    # raise params.to_yaml
    conditions = []
    conditions << "platform_type_id = '#{params[:platform_type_id]}'" if params[:platform_type_id].present?
    conditions << "country = '#{params[:country]}'" if params[:country].present?
    conditions << "category = '#{params[:category]}'" if params[:category].present?
    condition = conditions.join(' and ')
    if params[:facebook_page_count].present? and params[:facebook_page_count] == "htol"
      self.where(condition).order('facebook_page_count DESC')
    elsif params[:facebook_page_count].present? and params[:facebook_page_count] == "ltoh"
      self.where(condition).order('facebook_page_count ASC')
    else
      self.where(condition)
    end

  end

  def page_insight
    PageInsight.where(:facebook_page_id=>self.facebook_page_id)
  end

end
