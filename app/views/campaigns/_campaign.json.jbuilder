json.extract! campaign, :id, :title, :message, :description, :caption, :image, :url, :media_type, :platform_type, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)