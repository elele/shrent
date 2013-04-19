class WelcomeController < ApplicationController
	# 微信认证入口
	layout false
	def index
		if check_signature
			if request.get?
				render :text => params[:echostr]
			else
				@xml = Message.dispose(request.body.read)
				render :text => @xml 
			end
		else
			render :nothing => true
		end
	end

	private
	def check_signature
		signature = params[:signature]
		timestamp =  params[:timestamp]
		nonce = params[:nonce]
		echostr = params[:echostr]
		token = [TOKEN,timestamp.to_s,nonce.to_s].sort * ''
		signature == Digest::SHA1.hexdigest(token)
	end
end
