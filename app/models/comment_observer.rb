class CommentObserver < ActiveRecord::Observer
	observe Comment
	
	def after_create
		puts "We will notify #{article.user.email} of a new comment"
	end
	
end
