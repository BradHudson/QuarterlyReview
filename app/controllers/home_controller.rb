class HomeController < ApplicationController
  def index
    if session[:current_user].present?
      repos = {}
      binding.pry
      token = session[:current_user]["token"]
      name = session[:current_user]["name"]
      orgs_uri = "https://api.github.com/users/#{ name }/orgs"

      binding.pry
      @orgs= HTTParty.get(orgs_uri).parsed_response
      @orgs.each do |org|
        repos_uri = "https://api.github.com/orgs/#{ org }/repos?per_page=100"
        repos[:org] = HTTParty.get(repos_uri).parsed_response
      end
    end
  end

  private

  def headers
    # :headers => { "Authorization" => "token #{ token }"}
  end
end
