# encoding: utf-8

class Admin::UsersController < ApplicationController
  def new  
    @user = User.new  
  end  
    
  def create  
    @user = User.new(params[:user])  
    if @user.save  
      redirect_to root_url, :notice => "登录成功!"  
    else  
      render :new  
    end  
  end  
end
