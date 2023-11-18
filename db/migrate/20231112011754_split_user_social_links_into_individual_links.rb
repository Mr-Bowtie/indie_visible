class SplitUserSocialLinksIntoIndividualLinks < ActiveRecord::Migration[7.0]
  def change
    change_table(:users) do |t|
      t.remove(:social_links)
      t.column(:facebook_url, :string)
      t.column(:tiktok_url, :string)
      t.column(:instagram_url, :string)
    end
  end
end
