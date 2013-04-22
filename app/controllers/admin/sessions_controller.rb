# encoding: utf-8

class Admin::SessionsController < ApplicationController
  skip_before_filter :require_login
  def new
  end

  def create
    user = login(params[:email], params[:password],params[:remember_me])
    if user
      redirect_to admin_messages_path, :notice => "登录成功"
    else
      flash.now.alert = "邮件和密码错误"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, :notice => "注销"
  end
end
