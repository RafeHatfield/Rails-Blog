module ApplicationHelper
	
	# creates a submit button with the given name and a cancel link
	# accepts 2 arguments - form object and the cancel link name
	def submit_or_cancel(form, name='Cancel')
		form.submit + " or " + link_to(name, 'javascript:history.go(-1);', :class => 'cancel')
	end
	
end
