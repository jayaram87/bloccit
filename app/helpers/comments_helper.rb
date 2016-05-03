module CommentsHelper
    def user_is_authorized_for_comment?(comment)
        current_user && (current_user == topic_comment.user || current_user.admin?)
    end
end
