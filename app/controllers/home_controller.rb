class HomeController < ApplicationController
  def index
    if session[:current_user].present?
      repos = {}
      @token = session[:current_user]["token"]
      name = session[:current_user]["name"]

      #get the organizations for the user
      orgs_uri = "https://api.github.com/users/#{ name }/orgs"


      @orgs= HTTParty.get(orgs_uri).parsed_response

      #loop through each organization and list the repos
      # @orgs.each do |org|
      #   repos_uri = "https://api.github.com/orgs/#{ org }/repos?per_page=100"
      #   repos[:org] = HTTParty.get(repos_uri, headers: headers).parsed_response
      # end

      #once they select a repo, lets loop through the PR's for that repo

      org = 'cbdr'
      repo = 'consumer-main'
      author = 'BradHudson'
      date = '2017-05-01'
      prs_uri = "https://api.github.com/search/issues?q=is:pr+repo:#{ org }/#{ repo }+author:#{ author }+merged:>#{ date }"
      @pull_requests = HTTParty.get(prs_uri, headers: headers).parsed_response
    end

    #search PRS
    #
    #https://developer.github.com/v3/search/#search-issues
  end

  private

  def auth_login
    if session[:current_user].nil?
      redirect_to 'auth/github'
    end
  end

  def headers
    { "Authorization" => "token #{ @token }", "User-Agent" => "Awesome-Octocat-App"}
  end
end
