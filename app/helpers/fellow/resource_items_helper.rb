module Fellow::ResourceItemsHelper

	def date_validation(date_string)
		if date_string.nil?
			return false
		else
			d, m, y = date_string.split('/')
			return Date.valid_date?(y.to_i, m.to_i, d.to_i)
		end
	end
end
