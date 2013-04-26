class HousesController < ApplicationController
	skip_before_filter :require_login
	layout "weixin"
	def show
		@house = House.find params[:id]
	end

	def index
	end

end
