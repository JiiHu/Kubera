class WelcomeController < ApplicationController
  def index
    redirect_to users_path if !current_user.nil?
  end
end
