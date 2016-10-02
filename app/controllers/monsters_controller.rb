class MonstersController < ApplicationController
  skip_before_action :authenticate_user

  def index
    user = User.find(params[:user][:id])
    render :json => {:success => 'true', :user_monsters => user.user_monsters(user)}
  end

  def get_sorted_monster
    user = User.find(params[:user][:id])
    render :json => {:success => 'true', :user_monsters => user.user_monsters(user)}
  end

  def create
    user = User.find_by_session_token(params[:session_token])
    if user.monsters.blank?
      team = Team.create(:name => 'team1', :user_id => user.id)
      params[:monster][:team_id] = team.id
    end
    monster = Monster.new(monster_params)
    if monster.save
      render :json => {:success => 'true', :message => "Monster has been created successfully."}
    else
      render :json => {:success => 'false', :message => "Something went wrong,#{get_errors(monster.errors)}"}
    end
  end

  def show
    user = User.find_by_session_token(params[:session_token])
    monster = Monster.where(:id => params[:id], :user_id => user.id).first
    if monster.present?
      render :json => {:success => 'true', :monster => monster.monster_data_json(monster)}
    else
      render :json => {:success => 'false', :message => 'This monster doesn\'t exists or you don\'t have access to this monster.'}
    end
  end

  def update
    monster = Monster.find(params[:moster][:id])
    if monster.present?
      if monster.update(monster_params)
      else
        render :json => {:success => false, :message => get_errors(monster.errors)}
      end
    else
      render :json => {:success => 'false', :message => 'Monster doesn\'t exists'}
    end
  end

  def delete
    monster = Monster.find(params[:moster][:id])
    if monster.present?
      if monster.destroy
        render :json => {:sucess => 'true', :message => 'Monster deleted successfully.'}
      else
        render :json => {:success => 'false', :message => get_errors(monster.errors)}
      end
    else
      render :json => {:success => 'false', :message => 'Monster doesn\'t exists.'}
    end
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
