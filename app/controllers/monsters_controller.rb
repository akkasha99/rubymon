class MonstersController < ApplicationController
  skip_before_action :authenticate_user, :only => [:create]

  def create
    monster = Monster.new(monster_params)
    if monster.save
      render :json => {:success => "true", :message => "Monster has been created successfully."}
    else
      render :json => {:success => "false", :message => "Something went wrong,#{get_errors(monster.errors)}"}
    end
  end

  def show
    user = User.find_by_session_token(params[:session_token])
    monster = Monster.where(:id => params[:id], :user_id => user_id).first
    if monster.present?
      render :json => {:success => "true", :monster => monster_data_json(monster)}
    else
      render :json => {:success => "false", :message => 'This monster doesn\'t exists or you don\'t have access to this monster.'}
    end
  end

  def update

  end

  def delete

  end

  def get_errors(errors)
    error_string = ""
    errors.full_messages.each do |msg|
      error_string += msg
    end
  end

  private
  def monster_params
    params.require(:monster).permit(:name, :power, :type_id, :user_id, :team_id)
  end
end
