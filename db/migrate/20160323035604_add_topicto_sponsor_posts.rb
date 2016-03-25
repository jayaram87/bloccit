class AddTopictoSponsorPosts < ActiveRecord::Migration
  def change
    add_column :sponsor_posts, :topic_id, :integer
    add_index :sponsor_posts, :topic_id
  end
end
