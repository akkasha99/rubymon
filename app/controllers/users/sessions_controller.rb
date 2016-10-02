class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  skip_before_action :authenticate_user, :only => [:create]

# GET /resource/sign_in
# def new
#   super
# end

# POST /resource/sign_in
# def create
#   super
# end

  def create
    resource = warden.authenticate(:scope => resource_name, :recall => "#{controller_path}#failure")
    if request.format(request) == '*/*'
      if (resource.present?)
        sign_out(current_user) if current_user.present?
        random_str = SecureRandom.hex
        resource.update_attributes(:session_token => random_str)
        render :json => {:success => "true", :user => resource.user_data_json(resource), :user_monsters => user.user_monsters(user)}
      else
        render :json => {:success => "false", :message => "Oops! Something is missing. Your username or password may not have been typed in properly."}
      end
    end
  end

# DELETE /resource/sign_out
# def destroy
#   super
# end

# protected

# If you have extra params to permit, append them to the sanitizer.
# def configure_sign_in_params
#   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
# end
end
