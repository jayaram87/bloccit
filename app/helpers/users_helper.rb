module UsersHelper
    def user_posts(user)
        "{user.name} has not submitted any posts yet."
    end
    
    def user_comments(user)
        "{user.name} has not submitted any comments yet."
    end
end
