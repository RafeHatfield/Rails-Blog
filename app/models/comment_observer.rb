class CommentObserver < ActiveRecord::Observer
	
	observe Comment
	
		def after_create(comment)
			puts "We will notify #{comment.article.user.email} of a new comment"
		end
	
end