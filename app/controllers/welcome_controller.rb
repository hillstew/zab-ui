class WelcomeController < ApplicationController
  def index
    @client_id = ENV["CLIENT_ID"]
  end
end