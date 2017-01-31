class AddPostingLinkToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :posting_link, :text
  end
end
