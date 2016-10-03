class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, :allow_blank => false, :uniqueness => true, :presence => true
  validates :password, :presence => true
  has_many :monsters, :dependent => :destroy
  has_many :teams, :dependent => :destroy

  def user_data_json(user)
    {
        :id => user.id,
        :email => user.email,
        :session_token => user.session_token,
        :facebook_id => user.facebook_id.present? ? resource.facebook_id : ""
    }
  end

  def user_monsters(user)
    monsters = user.monsters
    if monsters.blank?
      []
    else
      monsters.map { |mon| {:id => mon.id, :name => mon.name, :type => mon.type.name} }
    end
  end

  def sorted_monsters(user, sort_by, sort_order)
    monsters = user.monsters.order(sort_by + ' ' + sort_order)
    if monsters.blank?
      []
    else
      monsters.map { |mon| mon.monster_data_json(mon) }
      # monsters.sort_by { |mon| mon.power.to_i }.map { |mon| mon.monster_data_json(mon) }.reverse
    end
  end

end
