module Fellow::ResourceItemsHelper

	def date_validation(date_string)
		if date_string.nil?
			return ''
		else
			y, m, d = date_string.split('/')
			if Date.valid_date?(y.to_i, m.to_i, d.to_i)
				return DateTime.parse(date_string).strftime("%Y-%m-%d")
			else 
				return ''
			end
		end
	end
end
