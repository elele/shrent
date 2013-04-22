class Admin::MessagesController < ApplicationController

	def index
		@messages = Message.paginate(:page => params[:page])
	end
end
