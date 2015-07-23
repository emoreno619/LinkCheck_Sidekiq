require 'nokogiri'


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
		if @site.save
			redirect_to sites_path
		else
			render :index
		end
	end

end
