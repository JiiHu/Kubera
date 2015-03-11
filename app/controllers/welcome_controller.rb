class WelcomeController < ApplicationController
  def index
    redirect_to current_user if !current_user.nil?
  end
end
