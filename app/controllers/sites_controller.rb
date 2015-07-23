class SitesController < ApplicationController
	def index
		@sites = Site.all
		@site = Site.new
	end

	def create
		@site = Site.new params.require(:site).permit(:url)
		if @site.save
			redirect_to sites_path
		else
			render :index
		end
	end

end
