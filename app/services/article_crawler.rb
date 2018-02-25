class ArticleCrawler
	attr_accessor :doc, :url, :publisher, :content

	def initialize(url)
		@url = url
		@doc = Nokogiri::HTML.parse(open(url, :allow_redirections => :safe))
		
	end

	def content
		self.doc.to_s
	end

	def title
		if !self.doc.at_css("meta[property='og:title']").nil? 
			self.doc.at_css("meta[property='og:title']")['content']
		elsif !self.doc.at_css("h1").nil?
			self.doc.at_css("h1").text
		else
			''
		end
	end

	def description
		self.doc.at_css("meta[property='og:description']").nil? ? nil : self.doc.at_css("meta[property='og:description']")['content']
	end

	def images
		images = []
		host = self.host_url
		title_image = self.doc.at_css("meta[property='og:image']").nil? ? nil : self.doc.at_css("meta[property='og:image']")['content']
		images << title_image if !title_image.nil?
		self.doc.css("img").each do |image_url|
			if !image_url['src'].nil?
				image_src = image_url['src'].start_with?('http') ? image_url['src'] : host + image_url['src']
				images << image_src
			end
		end
		return images
	end

	def publisher_name
		self.doc.at_css("meta[property='og:site_name']").nil? ? self.doc.at_css("title").text : self.doc.at_css("meta[property='og:site_name']")['content']
	end
	
	def get_host
	  uri = URI.parse(self.url)
	  uri = URI.parse("http://#{url}") if uri.scheme.nil?
	  host = uri.host.downcase
	  host.start_with?('www.') ? host[4..-1] : host
	end

	def host_url
		uri = URI.parse(self.url)
	  	uri = URI.parse("http://#{url}") if uri.scheme.nil?
	  	scheme = URI.parse(self.url).scheme
	  	scheme = "http" if uri.scheme.nil?
	  	host = scheme + '://' + uri.host
	end
end