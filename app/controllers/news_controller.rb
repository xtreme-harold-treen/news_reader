class NewsController < ApplicationController
	before_filter :get_stories, :only => :index
	
	def index
		@storys = Story.all
	end

	def get_stories

		Story.destroy_all
		
		section=params[:section]
		#require 'net/http'

		#url = URI.parse("http://api.usatoday.com/open/articles/topnews?encoding=json&api_key=8dvqgh88nraxmrs4km3anmgf")
		#request = Net::HTTP::Get.new(url.path)
		#response = Net::HTTP.start(url.host, url.port) { | http |
		#	http.request(request)
		#}
		
		response = HTTParty.get("http://api.usatoday.com/open/articles/topnews#{section}?encoding=json&api_key=8dvqgh88nraxmrs4km3anmgf")

		results = ActiveSupport::JSON.decode(response.body)['stories']

		results.each { |story|
			new_story = Story.new( :title => story['title'],
										  :description => story['description'],
										  :date => story['pubDate'],
										  :link => story['link'] )
			new_story.save
		}
	end
end
