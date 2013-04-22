# encoding: utf-8

class Admin::UsersController < ApplicationController
  skip_before_filter :require_login
  def new  
    @user = User.new  
  end  
    
  def create  
    @user = User.new(params[:user])  
    if @user.save  
      redirect_to login_path, :notice => "登录成功!"  
    else  
      render :new  
    end  
  end  
end
