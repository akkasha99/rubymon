class ApplicationController < ActionController::API
  before_action :authenticate_user

  def authenticate_user
    if params[:session_token].present?
      user = User.find_by_session_token(params[:session_token])
      if user.blank? or user.status == 'inactive'
        render :json => {:success => 'false', :errors => 'Authentication failed'}
        return
      end
    else
      render :json => {:success => 'false', :errors => 'Authentication failed'}
    end
  end
end
