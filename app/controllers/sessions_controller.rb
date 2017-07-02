class SessionsController < ApplicationController
  def new
  end
  def create
    auth_hash = request.env['omniauth.auth']
    @authorization = Authorization.find_by provider: auth_hash["provider"], uid: auth_hash["uid"]
    if @authorization
      session[:current_user] = @authorization
      flash[:notice] = "Welcome Back #{ session[:current_user].name }!"
      redirect_to '/'
    else
      user = User.new :name => auth_hash["info"]["nickname"], :email => auth_hash["info"]["email"], :token => auth_hash["credentials"]["token"]
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      session[:current_user] = user
      user.save
      flash[:notice] = "Welcome Aboard #{ session[:current_user].name }!"
      redirect_to '/'
    end
  end

  def failure

  end

  def destroy
    session[:current_user] = nil
    flash[:notice] = "Logged Out"
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
