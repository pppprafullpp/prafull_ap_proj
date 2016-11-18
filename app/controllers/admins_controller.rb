class AdminsController < ApplicationController
  before_filter :redirect_to_admin_panel
  def index
  end
  def redirect_to_admin_panel
    redirect_to "http://103.243.5.242:4100"
  end
end
