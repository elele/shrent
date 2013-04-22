# encoding: utf-8

class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password],params[:remember_me])
    if user
      redirect_back_or_to messages_paht, :notice => "登录成功"
    else
      flash.now.alert = "邮件和密码错误"
    end
  end

  def destroy
    logout
    redirect_to login_path, :notice => "注销"
  end
end
