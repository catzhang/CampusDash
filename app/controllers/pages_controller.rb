# require_relative 'tokenizer'

class PagesController < ApplicationController
  
  include TwilioHelper

  def index
    if session[:account].nil?
      redirect_to "/pages/login"
    end
  end
  
  def board
    if session[:account].nil?
      redirect_to "/pages/login"
    end
  end
  def logoff
    session[:account] = nil
    redirect_to "/pages/login"
  end
  
  def loginA
    username = params[:login][:username]
    password = params[:login][:password]
    if (User.find_by_phone(username).nil?)
      flash[:notice] = "Incorrect phone number"
    end
    if (not User.find_by_phone(username).nil?) and (User.find_by_phone(username).password == password)
    flash[:notice] = "Welcome phone"
      session[:account] = User.find_by_phone(username).id
      redirect_to "/pages/board"
    end
    
    redirect_to "/pages/login"
    
  end
  
  def register
    name = params[:register][:name]
    school = params[:register][:school]
    phone = params[:register][:phoneNumber]
    pass = params[:register][:password]
    
    verificationCode = SecureRandom.hex(2)
    while not User.find_by_code(verificationCode).nil?
      verificationCode = SecureRandom.hex(2)
    end
    User.create(name: name,phone: phone, school: school, password: pass,code:verificationCode)
    flash[:success] = "Verify, #{name}!"
    
    send_sms(phone, "Hey, #{name}! Your verification code is: #{verificationCode}")
    
    redirect_to "/pages/verify"
    
  end
  
  
  def sendRequest
    
    name = User.find(session[:account]).name
    number = User.find(session[:account]).phone
    toAddress = User.find(session[:account]).school
    fromAddress = params[:info][:fromaddress]
    restaurant = params[:info][:restaurant]
    food = params[:info][:food]
    
    Post.create(shop:restaurant,name:name,food:food,shopaddr:toAddress,pickup:toAddress,phonenumber:number)
    #ACCESS THE STUFF:
    #-<% @Post.comments.each do |msg| %>-->
    #msg.name << THE NAME OF THE CLIENT
    #msg.
    
    redirect_to "/pages/board"
  end
  
  def pickUp
    clientPhone = params[:bananna][:ph]
    if clientPhone == User.find(session[:account]).phone
      redirect_to "/pages/board"
    else
      # send to the client
      send_sms(clientPhone, User.find(session[:account]).name + " has decided to pick up your order. You may contact " + User.find(session[:account]).name+ " at " + User.find(session[:account]).phone)
      # send to the delivery guy
      send_sms(User.find(session[:account]).phone, "You are picking up " + User.find_by_phone(clientPhone).name + "'s food. You may contact him/her at " + clientPhone)
      Post.find(params[:bananna][:idPost]).destroy
     redirect_to "/"
    end
    
  end
    
  def getSchool
  end
  
  def confirm
    code = params[:cc][:code]
    if not User.find_by_code(code).nil?
      session[:account] = User.find_by_code(code).id
      User.find_by_code(code).update_column(:code, nil)
      redirect_to "/pages/board"
    else
      flash[:notice] = "Verification code is incorrect"
      redirect_to "/pages/verify"
    end
  end
end