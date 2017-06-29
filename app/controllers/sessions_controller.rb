class SessionsController < ApplicationController
  def new

  end
  def create
    # @user = User.find_or_create_from_auth_hash(auth_hash)
    # self.current_user = @user
    # redirect_to '/'
    auth_hash = request.env['omniauth.auth']

    binding.pry
    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
    else
      user = User.new :name => auth_hash["info"]["nickname"], :email => auth_hash["info"]["email"], :token => auth_hash["info"]["credentials"]["token"]
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save

      render :text => "Hi #{user.name}! You've signed up."
    end
  end

  def failure

  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
