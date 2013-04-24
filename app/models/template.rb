# encoding: utf-8

class Template

	WELCOME_MSG = %q|您好,感谢关注上海租房\n功能正在紧张开发中,尽请期待.|
	HELP_MSG = %Q|---上海租房帮助信息---
	指令列表:
	h help   查看帮助信息
	cz        查看当天出租信息
	cz 2013-01-01
  		查看某一天的出租信息
	qz      查看当天求租信息
	qz 2013-01-01 
			查看某天求租信息

	发布出租信息格式:
	【出租】标题/地址/详情/价格
	示例: 【出租】有一间合租房,20平方,求异性,本人女/江苏路XXX号XXX小区/详情内容/1000
	价格不填写为面议,其它信息必须添加才能发布成功.
	发布成功后,请在发送一张照片,才能出现在当天的信息列表里.
	发布求租信息格式:
	【求租】标题/地址/详情/价格
	求租信息不一定要求上传图片,上传图片能增加求租成功率.|


	def self.render_text(xml,text)
		return TEXT_TPL % [xml["xml"]["FromUserName"],xml["xml"]["ToUserName"],
  								Time.now.to_i,text]
	end

	def self.render_articles(xml,items,more_link)
		item_text = ""
		items.each do |item|
			if items.first == item
				img_url = DOMIAN + item.avatar.big.url
			else
				img_url = DOMIAN + item.avatar.thumb.url
			end
			item_text << ITEM_TPL % [item.title,item.content,img_url,"#{DOMIAN}/houses/#{item.id}",more_link]
		end
		return NEW_TPL % [xml["xml"]["FromUserName"],xml["xml"]["ToUserName"],Time.now.to_i,
											items.size,item_text]
	end
end