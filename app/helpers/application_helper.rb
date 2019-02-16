module ApplicationHelper
	def post_date(date)
	    date.strftime("%d/%m/%Y - %H:%M")
  	end
end