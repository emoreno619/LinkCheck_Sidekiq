require 'nokogiri'
require 'open-uri'



class SitesController < ApplicationController
	def index
		@sites = Site.all
		@site = Site.new
	end

	def create
		@site = Site.new params.require(:site).permit(:url)
		puts params[:site]["url"]
		response = RestClient.get(params[:site]["url"], :user_agent => 'Chrome')
		@site.update_attributes(:html => response)
		nokodoc = Nokogiri::HTML(open(@site.url))
		
		w = nokodoc.css('a')
		links = []

		w.each do |link|
 			if link.attributes['href']
				links.push(link.attributes['href'].value)
			end
		end
		
		@request = Typhoeus.get(links[0])
		binding.pry
		puts @request.options[:response_code]

		# links.each do |link|
		# 	@request = Typhoeus.get(link)

		# end


		if @site.save
			redirect_to sites_path
		else
			render :index
		end
	end

end
