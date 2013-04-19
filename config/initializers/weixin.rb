# encoding: utf-8

TOKEN = "c95c12f785d7e18a9755bc8842a0366d" #密钥


# 返回的模版
TEXT_TPL = "<xml>
              <ToUserName><![CDATA[%s]]></ToUserName>
              <FromUserName><![CDATA[%s]]></FromUserName>
              <CreateTime>%s</CreateTime>
              <MsgType><![CDATA[text]]></MsgType>
              <Content><![CDATA[%s]]></Content>
              <FuncFlag>0</FuncFlag>
              </xml>"
NEW_TPL = "<xml>
	           <ToUserName><![CDATA[%s]]></ToUserName>
	           <FromUserName><![CDATA[news]]></FromUserName>
	           <CreateTime>%s</CreateTime>
	           <MsgType><![CDATA[%s]]></MsgType>
	           <Content><![CDATA[%s]]></Content>
	           <ArticleCount>%d</ArticleCount>
	           <Articles>
	           %s
	           </Articles>
	           <FuncFlag>0</FuncFlag>
           </xml>"
ITEM_TPL = "<item>
	           <Title><![CDATA[%s]]></Title>
	           <Discription><![CDATA[%s]]></Discription>
	           <PicUrl><![CDATA[%s]]></PicUrl>
	           <Url><![CDATA[%s]]></Url>
           </item>"

