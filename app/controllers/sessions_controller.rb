class SessionsController < ApplicationController
  def new

  end
  def create
    # @user = User.find_or_create_from_auth_hash(auth_hash)
    # self.current_user = @user
    # redirect_to '/'
    auth_hash = request.env['omniauth.auth']

    render :text => auth_hash.inspect
  end

  def failure

  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
