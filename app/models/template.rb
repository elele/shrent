# encoding: utf-8

class Template

	WELCOME_MSG = %q|您好,感谢关注上海租房\n功能正在紧张开发中,尽请期待.|
	HELP_MSG = %Q|---上海租房帮助信息---
	指令列表:
	h 查看帮助信息
	1 查看出租信息
	2 查看求租信息
	发布出租信息格式:
	【出租】出租信息
	示例: 【出租】有一间合租房,20平方,求异性,本人女 江苏路XXX号XXX小区 1000元/月
	发布成功后,请在发送止少一张照片,才能出现在当天的信息列表里.
	发布求租信息格式:
	【求租】求租内容
	求租信息不一定要求上传图片,上传图片能增加求租成功率.|


	def self.render_text(xml,text)
		return TEXT_TPL % [xml["xml"]["FromUserName"],xml["xml"]["ToUserName"],
  								Time.now.to_i,text]
	end

	def self.render_articles(xml,items,size)
		return NEW_TPL % [xml["xml"]["FromUserName"],xml["xml"]["ToUserName"],Time.now.to_i,
											size,items]
	end
end