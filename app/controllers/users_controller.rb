class UsersController < ApplicationController
  skip_before_filter :authenticate_user, :only => []

  def index
    user = User.find_by_session_token(params[:session_token])
    render :json => {:success => "true", :user_monsters => user_monsters(user)}
  end

end
