class WelcomeController < ApplicationController
  def index
    redirect_to entries_path if !current_user.nil?
  end
end
