module UsersHelper
    def has_posts?(user)
        user.posts.count > 0
    end
    
    def has_comments?(user)
        user.comments.count > 0
    end
end
