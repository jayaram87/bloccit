class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  after_create :self_favorite_emails
 
  validates :body, length: { minimum: 5}, presence: true
  validates :user, presence: true
  
  private
  def self_favorite_emails
    post.favorites.each do |favorite|
      FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
    end
  end
end
