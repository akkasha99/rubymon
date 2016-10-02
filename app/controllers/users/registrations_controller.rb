class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user, :only => [:create]
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

# GET /resource/sign_up
# def new
#   super
# end

# POST /resource
# def create
#   super
# end

# GET /resource/edit
# def edit
#   super
# end

# PUT /resource
# def update
#   super
# end

# DELETE /resource
# def destroy
#   super
# end

# GET /resource/cancel
# Forces the session data which is usually expired after sign
# in to be expired now. This is useful if the user wants to
# cancel oauth signing in/up in the middle of the process,
# removing all OAuth session data.
# def cancel
#   super
# end

  def facebook_sign_up
    if request.format(request) == '*/*'
      if params[:facebook_id].present?
        user = User.where(:facebook_id => params[:facebook_id]).first
        if user.present?
          sign_out(current_user) if current_user.present?
          random_str = SecureRandom.hex
          user.update_attributes(:device_token => params[:user][:device_token], :session_token => random_str, :avatar_url => params[:user][:avatar_url])
          render :json => {:success => "true", :user => user.user_data_json(user), :user_monsters => user.user_monsters(user)}
        else
          random_str = SecureRandom.hex
          user = User.new(:email => params[:user][:email], :password => SecureRandom.hex, :session_token => random_str, :facebook_id => params[:facebook_id])
          if user.save
            render :json => {:success => "true", :user => user.user_data_json(user), :user_monsters => user.user_monsters(user)}
          else
            @errors = user.errors
            error_string = ""
            @errors.full_messages.each do |msg|
              error_string += msg + (".")
            end
            render :json => {:success => "false", :message => "#{error_string}"}
          end
        end
      else
        render :json => {:success => "false", :message => "Unable to sign-up, Facebook ID doesn't exists."}
      end
    end
  end

# protected

# If you have extra params to permit, append them to the sanitizer.
# def configure_sign_up_params
#   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
# end

# If you have extra params to permit, append them to the sanitizer.
# def configure_account_update_params
#   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
# end

# The path used after sign up.
# def after_sign_up_path_for(resource)
#   super(resource)
# end

# The path used after sign up for inactive accounts.
# def after_inactive_sign_up_path_for(resource)
#   super(resource)
# end
end
